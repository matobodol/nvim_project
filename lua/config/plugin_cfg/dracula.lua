{
	"Mofiqul/dracula.nvim",

lazy = false,
name = "dracula",
config = function()
	require("dracula").setup({
		-- show the '~' characters after the end of buffers
		show_end_of_buffer = false, -- default false
		-- use transparent background
		transparent_bg = false, -- default false
		-- set custom lualine background color
		-- lualine_bg_color = "#44475a", -- default nil
		-- set italic comment
		italic_comment = false, -- default false
	})
	vim.cmd("colorscheme dracula")
end,
}
