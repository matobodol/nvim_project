local icon = require("var.icons")


vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
vim.keymap.set("n", "gh", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "gf", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)

-- Konfigurasi awal diagnostic
local diagnostics_enabled = true -- aktif default

-- Fungsi untuk mengatur diagnostic
local function set_diagnostics()
	local severity = vim.diagnostic.severity
	vim.diagnostic.config({
		signs = {
			active = true,
			text = {
				[severity.ERROR] = icon.diagnostics.Error, -- Contoh: Ikon Font Awesome untuk Error
				[severity.WARN]  = icon.diagnostics.Warn, -- Contoh: Ikon Font Awesome untuk Warning
				[severity.INFO]  = icon.diagnostics.Info, -- Contoh: Ikon Font Awesome untuk Info
				[severity.HINT]  = icon.diagnostics.Hint, -- Contoh: Ikon Font Awesome untuk Hint (atau )
			},
		},
		virtual_text = diagnostics_enabled,
		update_in_insert = false,
		underline = true, -- Mengaktifkan garis bawah pada teks bermasalah
		severity_sort = true, -- Urutkan diagnostik berdasarkan tingkat keparahan
		float = {
			source = true,
			border = "rounded",
		},
	})
end

-- Konfigurasi awal
set_diagnostics()

-- Keymap toggle
vim.keymap.set("n", "<leader>td", function()
	diagnostics_enabled = not diagnostics_enabled
	set_diagnostics()
	local status = diagnostics_enabled and "enabled" or "disabled"
	vim.notify("Diagnostic virtual_text " .. status, vim.log.levels.INFO)
end, { desc = "Toggle Diagnostic virtual_text", noremap = true, silent = true })
