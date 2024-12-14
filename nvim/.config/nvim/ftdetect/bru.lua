-- Add Bru filetype detection using Lua
-- vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
-- 	pattern = "*.bru",
-- 	command = "set filetype=bru",
-- })
--
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.bru",
	callback = function()
		vim.bo.filetype = "bru"
	end,
})
