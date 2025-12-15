local ensure_installed = {
	"pyright",
	"bashls",
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = ensure_installed,
	automatic_installation = false,
})

-- load from os paket manager
local servers = {
	"lua_ls",
	"rust_analyzer",
}


local servers_mason = require("mason-lspconfig").get_installed_servers()
for _, lsp_installed in ipairs(servers_mason) do
	table.insert(servers, lsp_installed)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp in ipairs(servers) do
	local opts = {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			local status_navic_ok, nvim_navic = pcall(require, "nvim-navic")
			if status_navic_ok then
				if client.server_capabilities["documentSymbolProvider"] then
					nvim_navic.attach(client, bufnr)
				end
			end


			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			vim.keymap.set("n", "<leader>th", function()
				local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
				vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
			end, { buffer = bufnr })
		end,
	}

	-- LOAD LANGUAGE SETTINGS
	local ok, lang_opts = pcall(require, "config.lsp_cfg.language_settings." .. lsp)
	if ok and type(lang_opts) == "table" then
		opts.settings = lang_opts
	end

	-- integrasi nvim-navic
	vim.lsp.config(lsp, opts)
	vim.lsp.enable(lsp)
end
