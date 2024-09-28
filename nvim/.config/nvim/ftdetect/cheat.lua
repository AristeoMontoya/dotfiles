vim.api.nvim_create_augroup("FileTypeDetect", { clear = true })

vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile", "BufRead" }, {
	pattern = "*.cheat",
	callback = function()
		vim.opt.filetype = "navi"
	end,
	group = "FileTypeDetect",
})
