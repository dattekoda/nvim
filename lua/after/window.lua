vim.keymap.set('n', '<Space>n', '<Cmd>vsplit | wincmd l<CR>', { silent = true })
vim.keymap.set('n', '<Space>q', '<Cmd>q<CR>', { silent = true })

vim.keymap.set({'n','i','t'}, '<C-t>', function()
	vim.cmd('vsplit | wincmd l | terminal')
	vim.cmd('startinsert')
end, { silent = true })
vim.keymap.set({'n','i','t'}, '<C-v>', '<Cmd>vsplit | wincmd l<CR>', { silent = true })

local function toggle_window_left_right()
	local current_win = vim.fn.winnr()

	vim.cmd('wincmd h')
	if vim.fn.winnr() ~= current_win then
		return
	end
	vim.cmd('wincmd l')
end

vim.keymap.set({'n','t'}, '<C-j>', toggle_window_left_right, { silent = true })
vim.keymap.set('i', '<C-j>', function()
	vim.cmd('stopinsert')
	toggle_window_left_right()
end, { silent = true })

local function close_adjacent_window()
	toggle_window_left_right()
	vim.cmd('q')
end

vim.keymap.set({'n','i','t'}, '<C-k>', close_adjacent_window, { silent = true })

local function resize_left()
	if vim.fn.winnr('l') ~= vim.fn.winnr() then
		vim.cmd('vertical resize -2')
	else
		vim.cmd('vertical resize +2')
	end
end
local function resize_right()
	if vim.fn.winnr('l') ~= vim.fn.winnr() then
		vim.cmd('vertical resize +2')
	else
		vim.cmd('vertical resize -2')
	end
end
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'netrw',
	callback = function()
		vim.keymap.set('n', '<C-l>', resize_right, { buffer = true, silent = true })
		vim.keymap.set('n', '<C-h>', resize_left, { buffer = true, silent = true })
	end
})
vim.keymap.set('n', '<C-l>', resize_right, { silent = true })
vim.keymap.set('n', '<C-h>', resize_left, { silent = true })
