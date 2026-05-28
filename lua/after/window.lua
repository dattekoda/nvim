vim.keymap.set('n', '<Space>t', ':vsplit | wincmd l | terminal<CR>', { silent = true })
vim.keymap.set('n', '<Space>n', ':vsplit | wincmd l<CR>', { silent = true })

local function toggle_window_left_right()
	local current_win = vim.fn.winnr()

	vim.cmd('wincmd h')
	if vim.fn.winnr() ~= current_win then
		return
	end
	vim.cmd('wincmd l')
end

vim.keymap.set('n', '<C-j>', toggle_window_left_right, { silent = true })
vim.keymap.set('t', '<C-j>', toggle_window_left_right, { silent = true })
-- vim.keymap.set('n', '<M-j>', function() vim.cmd('wincmd h') end, { silent = true })
-- vim.keymap.set('n', '<M-k>', function() vim.cmd('wincmd l') end, { silent = true })
vim.keymap.set('n', '<Space>q', ':q<CR>', { silent = true })

