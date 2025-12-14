-- Telescope
return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope", -- Load saat command dipanggil
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>" },
			{ "<leader>fn", "<cmd>Telescope notify<cr>" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("telescope").setup()
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",                    -- Compile saat install
		cond = vim.fn.executable("make") == 1, -- Conditional install
	},
}
