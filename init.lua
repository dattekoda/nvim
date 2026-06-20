vim.g.mapleader = " "
require("dattekoda.lazy")

require("after.clipboard")
require("after.window")
require("after.telescope");
require("after.keymap")
require("after.root")
require("after.lsp")
require("after.header");

vim.opt.list = true
vim.opt.listchars = { tab = '< |', trail = '.' }
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

