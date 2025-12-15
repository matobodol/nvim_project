return {
	-- ========== ESSENTIALS (Non-lazy) ==========
	{
		"nvim-lua/plenary.nvim",
		lazy = false, -- Dibutuhkan oleh banyak plugin
		priority = 1000, -- High priority
	},

	{
		"nvim-lua/popup.nvim",
		lazy = false,
		priority = 1000,
	},

	-- ========== EDITOR ENHANCEMENTS ==========
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- Lazy load saat insert mode
		config = true,
	},

	{
		"numToStr/Comment.nvim",
		keys = { -- Lazy load saat keys ditekan
			{ "gc", mode = { "n", "v" } },
			{ "gb", mode = { "n", "v" } },
		},
		config = true,
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy", -- Load sangat telat
		config = true,
	},

	-- ========== BUFFER & WINDOW MANAGEMENT ==========
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre", -- Load saat buffer dibaca
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				mode = "buffers",
				separator_style = "slant",
			},
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- Load saat command dipanggil
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>" },
		},
		config = function()
			require("nvim-tree").setup({

				hijack_directories = {
					enable = false,
					auto_open = true,
				},
				update_focused_file = {
					enable = true,
					debounce_delay = 15,
					update_root = true,
					ignore_list = {},
				},

				diagnostics = {
					enable = true,
					show_on_dirs = false,
					show_on_open_dirs = true,
					debounce_delay = 50,
					severity = {
						min = vim.diagnostic.severity.HINT,
						max = vim.diagnostic.severity.ERROR,
					},
					icons = {
						hint = "⚑",
						info = "",
						warning = "",
						error = "",
					},
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"utilyre/barbecue.nvim",
		event = "InsertEnter",
		name = "barbecue",
		version = "*",

		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
	},
}
