local M = {}

-- State
M.float_state = {
	buf = nil,
	win = nil,
	is_open = false,
	job_id = nil
}

-- Config dengan border options lengkap
M.float_config = {
	-- Window size
	width = 0.8,
	height = 0.7,
	position = "center", -- "center", "top", "bottom", "left", "right"
	title = "Terminal",

	-- Border configuration
	border = "rounded", -- Pilihan: "none", "single", "double", "rounded", "solid", "shadow"

	-- Border style kustom (jika ingin lebih kontrol)
	border_style = {
		-- Hanya digunakan jika border = "custom"
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	},

	-- Keymap config
	toggle_key = "<A-i>", -- Alt+i
	exit_key = "<Esc>", -- Exit terminal mode
}

-- Setup
function M.setup(user_config)
	if user_config then
		M.float_config = vim.tbl_deep_extend("force", M.float_config, user_config)
	end

	M.setup_keymaps()
	M.setup_autocmds()

	-- local border_type = M.float_config.border
	-- vim.notify("Terminal ready with '" .. border_type .. "' border! Use " .. M.float_config.toggle_key,
	-- vim.log.levels.INFO)
end

-- Get border config berdasarkan pilihan
function M.get_border_config()
	local border_type = M.float_config.border

	if border_type == "none" then
		return nil
	elseif border_type == "custom" then
		return M.float_config.border_style
	else
		return border_type -- "single", "double", "rounded", "solid", "shadow"
	end
end

-- Setup keymaps
function M.setup_keymaps()
	local toggle_key = M.float_config.toggle_key

	-- Normal mode
	vim.keymap.set("n", toggle_key, M.toggle, {
		desc = "Toggle floating terminal",
		noremap = true,
		silent = true
	})

	-- Insert mode
	vim.keymap.set("i", toggle_key, function()
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
			"n",
			false
		)
		M.toggle()
	end, {
		desc = "Toggle floating terminal",
		noremap = true,
		silent = true
	})

	-- Visual mode
	vim.keymap.set("v", toggle_key, function()
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
			"n",
			false
		)
		M.toggle()
	end, {
		desc = "Toggle floating terminal",
		noremap = true,
		silent = true
	})
end

--
-- Setup terminal keymaps
function M.setup_terminal_keymaps()
	if not M.float_state.buf then return end

	local toggle_key = M.float_config.toggle_key
	local exit_key = M.float_config.exit_key

	-- Terminal mode: Alt+i untuk hide
	vim.keymap.set("t", toggle_key, function()
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
			"n",
			false
		)
		M.hide()
	end, {
		buffer = M.float_state.buf,
		desc = "Hide terminal",
		noremap = true,
		silent = true
	})

	-- Terminal mode: ESC untuk normal mode
	vim.keymap.set("t", exit_key, "<C-\\><C-n>", {
		buffer = M.float_state.buf,
		desc = "Exit terminal mode",
		noremap = true,
		silent = true
	})
end

-- Setup autocmds
function M.setup_autocmds()
	local group = vim.api.nvim_create_augroup("FloatingTerminal", { clear = true })

	vim.api.nvim_create_autocmd("TermOpen", {
		group = group,
		callback = function(args)
			if args.buf == M.float_state.buf then
				M.setup_terminal_keymaps()
			end
		end,
	})

	vim.api.nvim_create_autocmd("TermClose", {
		group = group,
		pattern = "*",
		callback = function(args)
			if args.buf == M.float_state.buf then
				vim.schedule(function()
					M.close()
				end)
			end
		end,
	})
end

-- Toggle function
function M.toggle()
	if M.float_state.is_open and
		 M.float_state.win and
		 vim.api.nvim_win_is_valid(M.float_state.win) then
		M.hide()
	else
		M.open()
	end
end

-- Open terminal dengan border
function M.open()
	local cfg = M.float_config
	local width = math.floor(vim.o.columns * cfg.width)
	local height = math.floor(vim.o.lines * cfg.height)

	-- Calculate position
	local col, row
	if cfg.position == "center" then
		col = math.floor((vim.o.columns - width) / 2)
		row = math.floor((vim.o.lines - height) / 2)
	elseif cfg.position == "top" then
		col = math.floor((vim.o.columns - width) / 2)
		row = 1
	elseif cfg.position == "bottom" then
		col = math.floor((vim.o.columns - width) / 2)
		row = vim.o.lines - height - 2
	elseif cfg.position == "left" then
		col = 1
		row = math.floor((vim.o.lines - height) / 2)
	elseif cfg.position == "right" then
		col = vim.o.columns - width - 2
		row = math.floor((vim.o.lines - height) / 2)
	end

	-- Create buffer
	if not M.float_state.buf or not vim.api.nvim_buf_is_valid(M.float_state.buf) then
		M.float_state.buf = vim.api.nvim_create_buf(false, true)
	end

	-- Get border config
	local border = M.get_border_config()

	-- Create window options dengan border
	local win_opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		title = cfg.title,
		title_pos = "center",
	}

	-- Tambahkan border jika ada
	if border then
		win_opts.border = border
	end

	-- Create atau update window
	if M.float_state.win and vim.api.nvim_win_is_valid(M.float_state.win) then
		vim.api.nvim_win_set_config(M.float_state.win, win_opts)
		vim.api.nvim_win_show(M.float_state.win)
	else
		M.float_state.win = vim.api.nvim_open_win(M.float_state.buf, true, win_opts)
	end

	-- Optional: Set window highlights untuk border yang lebih bagus
	if border then
		vim.api.nvim_win_set_option(M.float_state.win, "winhl", "Normal:NormalFloat,Border:FloatBorder")
	end

	-- Start terminal
	if vim.bo[M.float_state.buf].buftype ~= "terminal" then
		vim.fn.termopen(vim.o.shell, {
			on_exit = function(_, code, _)
				M.float_state.job_id = nil
				vim.schedule(function()
					if code == 0 then
						M.close()
					end
				end)
			end
		})

		M.float_state.job_id = vim.b.terminal_job_id
	end

	-- Enter insert mode
	vim.cmd("startinsert")
	M.float_state.is_open = true

	-- Setup terminal keymaps
	M.setup_terminal_keymaps()
end

-- Hide terminal
function M.hide()
	if M.float_state.win and vim.api.nvim_win_is_valid(M.float_state.win) then
		vim.api.nvim_win_hide(M.float_state.win)
		M.float_state.is_open = false
	end
end

-- Close terminal
function M.close()
	if M.float_state.win and vim.api.nvim_win_is_valid(M.float_state.win) then
		vim.api.nvim_win_close(M.float_state.win, true)
	end

	if M.float_state.buf and vim.api.nvim_buf_is_valid(M.float_state.buf) then
		vim.api.nvim_buf_delete(M.float_state.buf, { force = true })
	end

	M.float_state = { buf = nil, win = nil, is_open = false, job_id = nil }
end

-- Fungsi untuk mengganti border style
function M.set_border(border_type)
	M.float_config.border = border_type

	-- Jika terminal terbuka, update dengan border baru
	if M.float_state.is_open then
		M.open() -- Re-open dengan border baru
	end

	print("Border changed to: " .. border_type)
end

-- Fungsi untuk melihat preview semua border style
function M.preview_borders()
	local borders = {
		"none", "single", "double", "rounded", "solid", "shadow"
	}

	print("=== Border Styles Preview ===")
	for i, border in ipairs(borders) do
		print(i .. ". " .. border)
	end
	print("\nTo change border:")
	print(":lua require('config.terminal').set_border('rounded')")
	print(":lua require('config.terminal').set_border('double')")
end

-- Helper untuk melihat config
function M.show_config()
	print("=== Terminal Config ===")
	print("Size: " .. (M.float_config.width * 100) .. "% x " .. (M.float_config.height * 100) .. "%")
	print("Border: " .. M.float_config.border)
	print("Position: " .. M.float_config.position)
	print("Toggle key: " .. M.float_config.toggle_key)
	print("Status: " .. (M.float_state.is_open and "OPEN" or "CLOSED"))
end

return M
