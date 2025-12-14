local icons = {
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = "⚑ ",
		Info = " ",
	},

	-- lualine
	separators = {
		component = {
			left = "",
			right = ""
		},
		section = {
			left = "",
			right = ""
		},
	},
	-- cmp
	menu_icon = {
		nvim_lsp = '', -- Atau ''
		luasnip = '', -- Atau ''
		buffer = '', -- Atau ''
		path = '', -- Atau ''
		cmdline = '', -- Tetap dipertahankan
	},

	-- nvimtree
	folder = {
		arrow_closed = "",
		arrow_open = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},

	git = {
		added = " ",
		modified = " ",
		removed = " ",
	},
	kinds = {
		Array = " ",
		Boolean = " ",
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Copilot = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = " ",
		Module = " ",
		Namespace = " ",
		Null = "ﳠ ",
		Number = " ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		String = " ",
		Struct = " ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	},
}

return icons
