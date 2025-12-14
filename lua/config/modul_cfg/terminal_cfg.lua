-- Load terminal dengan rounded border
require("moduls.terminal").setup({
	width = 0.85,
	height = 0.7,
	border = "rounded",  -- INI YANG MEMBUAT BORDER ROUNDED
	title = "Terminal",
	position = "center",
	toggle_key = "<A-i>",
})
