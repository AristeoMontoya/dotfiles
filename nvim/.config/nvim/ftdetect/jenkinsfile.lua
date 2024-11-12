vim.api.nvim_create_augroup("FileTypeDetect", { clear = true })

vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile", "BufRead" }, {
	pattern = "*.jenkinsfile",
	callback = function()
		vim.opt.filetype = "groovy"
	end,
	group = "FileTypeDetect",
})
