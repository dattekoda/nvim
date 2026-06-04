vim.opt.clipboard = 'unnamedplus'

local is_virtual = false
if vim.fn.executable('systemd-detect-virt') == 1 then
	local virt = vim.fn.trim(vim.fn.system('systemd-detect-virt'))
	if virt ~= 'none' and virt ~= '' then
		is_virtual = true
	end
end

if is_virtual then
	vim.g.clipboard = {
		name = 'OSC 52',
		copy = {
			['+'] = require('vim.ui.clipboard.osc52').copy('+'),
			['*'] = require('vim.ui.clipboard.osc52').copy('*'),
		},
		paste = {
			['+'] = require('vim.ui.clipboard.osc52').paste('+'),
			['*'] = require('vim.ui.clipboard.osc52').paste('*'),
		},
	}
else
	vim.g.clipboard = {
		name = 'xsel',
		copy = {
			['+'] = 'xsel --clipboard --input',
			['*'] = 'xsel --primary --input',
		},
		paste = {
			['+'] = 'xsel --clipboard --output',
			['*'] = 'xsel --primary --output',
		},
		cache_enabled = 1,
	}
end

