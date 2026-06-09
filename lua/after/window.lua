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

