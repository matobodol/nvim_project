-- Plugin untuk autocompletion


local status_ok, cmp = pcall(require, "cmp")
local icons          = require("var.icons")
if not status_ok then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- Untuk `LuaSnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Konfirmasi pilihan
		-- Keymap <Tab> akan kembali ke default/snippet bawaan vsnip (jika ada)
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- Sumber LSP
		{ name = "luasnip" },
		{ name = "path" }, -- Penyelesaian path
		{ name = "buffer" }, -- Penyelesaian buffer
		{ name = "cmdline" }, -- Penyelesaian command
	}),

	-- Ikon berdasarkan source
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, vim_item)
			local menu_icon = icons.menu_icon

			-- size menu char
			local ELLIPSIS_CHAR = '~'
			local MAX_LABEL_WIDTH = 16
			local MIN_LABEL_WIDTH = 5

			local label = vim_item.abbr
			local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
			if truncated_label ~= label then
				vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
			elseif string.len(label) < MIN_LABEL_WIDTH then
				local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
				vim_item.abbr = label .. padding
			end

			vim_item.menu = menu_icon[entry.source.name]
			return vim_item
		end,
	},
})

-- Pengaturan khusus untuk cmdline
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Pengaturan untuk pencarian (/ atau ?)
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
