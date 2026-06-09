-- リーダーキーをSpaceに設定（すでに別の場所で設定済みの場合は不要です）

vim.opt.updatetime = 100

vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = true,
	signs = true,
})

-- Telescopeの安全な読み込み
local telescope_status, builtin = pcall(require, 'telescope.builtin')
if telescope_status then
	-- <Space>の代わりに<leader>を使用し一貫性を保つ
	vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = 'Telescope Resume' })
end

vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("AutoShowDiagnostic", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})

vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- lspがバッファにアタッチされたときのみキーバインドを有効化する
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
		preselect = cmp.PreselectMode.None,
		completion = {
			completeopt = "menu,menuone,noselect",
		},
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = false }), 
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' }, 
		}, {
			{ name = 'buffer' },   
		})
	})
end

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cpp' },
	callback = function(ev)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		local cmd = { 'clangd', '--background-index' }

		vim.lsp.start({
			name = 'clangd',
			cmd = cmd,
			root_dir = vim.fs.root(0, { '.git', 'Makefile', 'compile_commands.json' }) or vim.fn.getcwd(),
			capabilities = capabilities,
		})
	end,
})
