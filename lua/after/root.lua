vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("SetCwdToArg", { clear = true }),
	callback = function()
		local first_arg = vim.fn.argv(0)

		if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
			vim.api.nvim_set_current_dir(first_arg)
		end
	end,
})

