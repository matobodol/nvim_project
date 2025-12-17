return {
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
	},
	-- ========== COLORSCHEME (Load pertama) ==========
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load segera untuk menghindari flash
		priority = 1000,
		config = function()
			-- vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- ========== STATUSLINE ==========
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy", -- Load setelah UI lain siap
		opts = {
			options = {
				theme = "tokyonight",
			},
		},
	},

	-- ========== INDENT GUIDES ==========
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		config = function()
			require("ibl").setup()
		end
	},

	-- Mini.nvim (horizontal scope)
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require('mini.indentscope').setup()
		end
	},

	-- ========== WHICH-KEY ==========
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},

	-- ========== NOTIFICATIONS ==========
	{
		"rcarriga/nvim-notify",
		-- event = "VeryLazy",
		lazy = false,
		keys = { -- Keymap langsung di plugin spec
			{ "<leader>hc", function() require("notify").clear_history() end, desc = "Clear notifications" },
			{ "<leader>hn", function() require("notify").history() end,       desc = "Show notification history" },
		},
		config = function()
			-- di plugins/init.lua
			require("notify").setup({
				-- Pengaturan ukuran
				max_width = function() return math.floor(vim.o.columns * 0.5) end,
				max_height = function() return math.floor(vim.o.lines * 0.5) end,

				timeout = 3000,
				-- Atau nilai tetap
				-- max_width = 80,
				-- max_height = 20,
				-- Enable history
				history = true, -- Simpan history
				render = "default",
				stages = "fade_in_slide_out",

				-- Posisi history window
				background_colour = "#1a1b26",
				fps = 30,
			})

			vim.notify = require("notify")
		end,
	},
}
