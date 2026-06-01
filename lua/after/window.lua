vim.keymap.set('n', '<Space>t', ':vsplit | wincmd l | terminal<CR>', { silent = true })
vim.keymap.set('n', '<Space>n', ':vsplit | wincmd l<CR>', { silent = true })

vim.keymap.set({'n','i','t'}, '<C-t>', '<Cmd>vsplit | wincmd l | terminal<CR>', { silent = true })
vim.keymap.set({'n','i','t'}, '<C-;>', '<Cmd>vsplit | wincmd l<CR>', { silent = true })

local function toggle_window_left_right()
	local current_win = vim.fn.winnr()

	vim.cmd('wincmd h')
	if vim.fn.winnr() ~= current_win then
		return
	end
	vim.cmd('wincmd l')
end

vim.keymap.set('n', '<C-j>', toggle_window_left_right, { silent = true })
vim.keymap.set('i', '<C-j>', function()
	vim.cmd('stopinsert')
	toggle_window_left_right()
end, { silent = true })
vim.keymap.set('t', '<C-j>', toggle_window_left_right, { silent = true })
vim.keymap.set('n', '<Space>q', ':q<CR>', { silent = true })

local function close_adjacent_window()
	toggle_window_left_right()
	vim.cmd('q')
end
vim.keymap.set('n', '<C-k>', close_adjacent_window, { silent = true })
vim.keymap.set('i', '<C-k>', close_adjacent_window, { silent = true })
vim.keymap.set('t', '<C-k>', close_adjacent_window, { silent = true })

