require("ibl").setup({
	enabled = true,
	debounce = 300,
	indent = {
		char = "│", --center
		smart_indent_cap = true,
	},
	scope = { enabled = false, },
})
vim.keymap.set('n', '<leader>ui', '<cmd>IBLToggle<cr>')

require('mini.indentscope').setup({
	symbol = "│", --center
	options = {
		try_as_border = true
	},
	draw = {
		-- Delay (in ms) between event and start of drawing scope indicator
		delay = 300,
		-- Symbol priority. Increase to display on top of more symbols.
		priority = 2,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"lsp",
		"help",
		"alpha",
		"dashboard",
		"neo-tree",
		"Trouble",
		"lazy",
		"mason",
		"notify",
		"toggleterm",
		"lazyterm",
		"NvimTree",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
