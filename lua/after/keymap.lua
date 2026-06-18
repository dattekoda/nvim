vim.keymap.set('n', '<Space>w', ':w<CR>', { silent = true })
vim.keymap.set('n', '<Space>wq', ':wq<CR>', { silent = true })
vim.keymap.set('n', '<Space>-', ':Ex<CR>', { silent = true })
vim.keymap.set('n', '<Space>ss', ':%s/', { silent = true })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })
