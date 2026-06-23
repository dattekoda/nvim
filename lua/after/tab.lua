vim.keymap.set('n', '<leader>o', ':tabnew<CR>:Ex<CR>', { silent = true })

vim.keymap.set('n', 'td', function()
	local ft = vim.bo.filetype
	if ft == 'netrw' then
		vim.api.nvim_feedkeys('t', 'n', false)
	else
		vim.cmd('tab split')
		vim.lsp.buf.definition()
	end
end, { noremap = true, silent = true })
