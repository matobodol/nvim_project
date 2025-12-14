local icons = require("var.icons")

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
		side = "left",
	},
	renderer = {
		group_empty = true,
		icons = {
			glyphs = {
				folder = icons.folder,
				-- git = icons.git,
			},
		},
	},
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
			hint = icons.diagnostics.Hint,
			info = icons.diagnostics.Info,
			warning = icons.diagnostics.Warn,
			error = icons.diagnostics.Error,
		},
	},
	filters = {
		dotfiles = false,
	},
})

-- Keymaps for nvim-tree
local keymap = vim.keymap
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>E", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })
