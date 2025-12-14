return {
	-- ========== COLORSCHEME (Load pertama) ==========
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load segera untuk menghindari flash
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
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
			local ibl = require("ibl")

			ibl.setup({
				enabled = true,
				debounce = 300,
				indent = {
					char = "│", --center
					smart_indent_cap = true,
				},
				scope = { enabled = false, },
			})
			vim.keymap.set('n', '<leader>ui', '<cmd>IBLToggle<cr>')
		end
	},

	-- Mini.nvim (horizontal scope)
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require('mini.indentscope').setup({
				symbol = "│", --center
				options = {
					try_as_border = true
				},
				draw = {
					-- Delay (in ms) between event and start of drawing scope indicator
					delay = 100,
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
		event = "VeryLazy",
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
				history = true,           -- Simpan history
				render = "default",
				stages = "fade_in_slide_out",

				-- Posisi history window
				background_colour = "#1a1b26",
				fps = 30,
			})

			vim.notify = require("notify")

		end,
		keys = {  -- Keymap langsung di plugin spec
			{ "<leader>hc", function() require("notify").dismiss() end, desc = "Clear notifications" },
			{ "<leader>hn", function() require("notify").history() end, desc = "Show notification history" },
		},
	},
}

