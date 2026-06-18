vim.keymap.set('n', '<Space>n', '<Cmd>vsplit | wincmd l<CR>', { silent = true })
vim.keymap.set('n', '<Space>q', '<Cmd>q<CR>', { silent = true })

vim.keymap.set({'n','i','t'}, '<C-t>', function()
	vim.cmd('vsplit | wincmd l | terminal')
	vim.cmd('startinsert')
end, { silent = true })
vim.keymap.set({'n','i','t'}, '<C-s>', '<Cmd>vsplit | wincmd l<CR>', { silent = true })

vim.keymap.set({'n'}, '<C-k>', '<C-w>w', { noremap = true, silent = true })
vim.keymap.set({'i'}, '<C-k>', '<Esc><C-w>w', { noremap = true, silent = true })
vim.keymap.set({'t'}, '<C-k>', '<C-\\><C-n><C-w>w', { noremap = true, silent = true })

vim.keymap.set({'n'}, '<C-j>', '<C-w>W', { noremap = true, silent = true })
vim.keymap.set({'i'}, '<C-j>', '<Esc><C-w>W', { noremap = true, silent = true })
vim.keymap.set({'t'}, '<C-j>', '<C-\\><C-n><C-w>W', { noremap = true, silent = true })

vim.keymap.set({'n','i','t'}, '<C-g>', '<Cmd>vsplit|wincmd l|Explore<CR>', { silent = true })

local function resize_left()
	if vim.fn.winnr('l') ~= vim.fn.winnr() then
		vim.cmd('vertical resize -10')
	else
		vim.cmd('vertical resize +10')
	end
end
local function resize_right()
	if vim.fn.winnr('l') ~= vim.fn.winnr() then
		vim.cmd('vertical resize +10')
	else
		vim.cmd('vertical resize -10')
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
