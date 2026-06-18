local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- telescope関連
return 

require("lazy").setup({
{
  "hrsh7th/nvim-cmp",
  -- dependencies を指定することで、親プラグインの前に必要なものが自動で読み込まれます
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  -- config 関数の中に、プラグイン読み込み直後に実行したい設定を書きます
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })
  end,
},
{
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_background = 'medium'
		vim.g.gruvbox_material_better_performance = 1
		vim.cmd('colorscheme gruvbox-material')
	end
},
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8', -- 最新の安定版を指定
    dependencies = {
      'nvim-lua/plenary.nvim' -- Telescopeが内部で利用する必須ライブラリ
    },
    config = function()
      local builtin = require('telescope.builtin')
      
      -- よく使う検索機能のショートカット（キーマップ）を設定
      -- <leader> はデフォルトではスペースキーやバックスラッシュです
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'ファイル名検索' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'ファイル内の文字列全探索 (Grep)' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '開いているバッファの検索' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Neovimのヘルプ検索' })
    end
  },
{
  "Diogo-ss/42-header.nvim",
  cmd = { "Stdheader" },
  keys = { "<F1>" },
  opts = {
    default_map = true, -- Default mapping <F1> in normal mode.
    auto_update = true, -- Update header when saving.
    user = "khanadat", -- Your user.
    mail = "khanadat@student.42tokyo.jp", -- Your mail.
    -- add other options.
  },
  config = function(_, opts)
    require("42header").setup(opts)
  end,
},
{
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
	end
}
})
