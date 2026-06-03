
--p lspがバッファにアタッチされたときのみキーバインドを有効化する
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('userlspconfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts ) -- 定義へジャンプ
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts) -- 変数名の一括変更
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- コードアクション
    vim.keymap.set('n', 'vd', function()
	    vim.cmd('vsplit | wincmd l')
	    vim.lsp.buf.definition()
    end, opts)
  end,
})

local cmp_status, cmp = pcall(require, "cmp")
if cmp_status then
  cmp.setup({
    -- ★追加: 候補の自動選択を完全に無効化
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noselect",
    },

    snippet = {
      -- 関数補完時の引数展開に LuaSnip を使用する
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(), -- 手動で補完ウィンドウをトリガー
      ['<C-e>'] = cmp.mapping.abort(),        -- 補完キャンセル
      -- ★変更: select = false にすることで、明示的に選択していない場合は単なる改行になる
      ['<CR>'] = cmp.mapping.confirm({ select = false }), 
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' }, -- LSPからのレコメンドを最優先
      { name = 'luasnip' },  -- スニペット
    }, {
      { name = 'buffer' },   -- ファイル内のテキストも補完候補に入れる場合
    })
  })
end

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cpp' },
	callback = function()
        -- nvim-cmpが提供する機能をLSP用の設定に変換
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if has_cmp then
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

		vim.lsp.start({
			name = 'clangd',
			cmd = { 'clangd' },
			root_dir = vim.fs.root(0, { '.git', 'Makefile' }) or vim.fn.getcwd(),
            capabilities = capabilities, -- clangdに補完機能があることを伝える
		})
	end,
})
