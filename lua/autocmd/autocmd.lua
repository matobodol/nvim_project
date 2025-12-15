local group = vim.api.nvim_create_augroup('custom_autocmds', { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual', timeout = 300 })
	end,
})

-- Keymap for help and man
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'help', 'man' },
	group = group,
	callback = function()
		vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>quit<cr>', { noremap = true, silent = true })
	end,
})

-- Terminal setup
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	group = group,
	callback = function()
		vim.cmd('setlocal nonumber norelativenumber')
		vim.cmd('startinsert')
	end,
})

-- Fungsi toggle untuk number dan relative number
local function toggle_number()
	if vim.o.number and vim.o.relativenumber then
		vim.o.number = false
		vim.o.relativenumber = false
	else
		vim.o.number = true
		vim.o.relativenumber = true
	end
end

-- Keymap untuk toggle
vim.keymap.set('n', '<leader>.', toggle_number, { desc = "toggle line number", noremap = true, silent = true })
