vim.keymap.set('n', '<leader>r', ':Telescope live_grep<CR>', { silent = true })
-- Telescopeの安全な読み込み
local telescope_status, builtin = pcall(require, 'telescope.builtin')
if telescope_status then
	-- <Space>の代わりに<leader>を使用し一貫性を保つ
	vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = 'Telescope Resume' })
end
