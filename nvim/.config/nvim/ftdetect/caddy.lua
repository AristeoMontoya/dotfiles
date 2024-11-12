vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "Caddyfile",
	callback = function()
		vim.bo.filetype = "caddy"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "Corefile",
	callback = function()
		vim.bo.filetype = "caddy"
	end,
})
