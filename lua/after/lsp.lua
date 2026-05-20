
--p lspがバッファにアタッチされたときのみキーバインドを有効化する
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('userlspconfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts ) -- 定義へジャンプ
    vim.keymap.set('n', 'k', vim.lsp.buf.hover, opts)       -- ホバーで情報表示
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- 変数名の一括変更
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- コードアクション
  end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cpp' },
	callback = function()
		vim.lsp.start({
			name = 'clangd',
			cmd = { 'clangd' },
			root_dir = vim.fs.root(0, { '.git', 'Makefile' }) or vim.fn.getcwd(),
		})
	end,
})
