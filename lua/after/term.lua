vim.keymap.set('n', '<Space>t', ':vsplit | wincmd l | terminal<CR>', { silent = true })

local function toggle_window_left_right()
	local current_win = vim.fn.winnr()

	vim.cmd('wincmd h')
	if vim.fn.winnr() ~= current_win then
		return
	end
	vim.cmd('wincmd l')
end

vim.keymap.set('n', '<Esc><Esc>', toggle_window_left_right, { silent = true })
vim.keymap.set('t', '<Esc><Esc>', toggle_window_left_right, { silent = true })
vim.keymap.set('n', '<Space>q', ':q<CR>', { silent = true })

