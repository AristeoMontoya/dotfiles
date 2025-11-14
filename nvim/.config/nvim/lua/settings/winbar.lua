local call_ok, get_files_count = pcall(require, "utils.count_listed_files") ---@type boolean, integer
if not call_ok then
	return
end

local function get_modified_symbol()
	if vim.bo.modified then
		return " ● "
	else
		return ""
	end
end

local winbar_hg_group = "WinBarDynamic"
local winbar_format = "%= %#" .. winbar_hg_group .. "#%m %t "

vim.api.nvim_create_autocmd({
	"CursorMoved",
	"CursorHold",
	"BufWinEnter",
	"BufFilePost",
	"InsertEnter",
	"BufWritePost",
	"TabClosed",
}, {
	group = vim.api.nvim_create_augroup("winbar_when_needed", { clear = true }),
	callback = function()
		if not call_ok then
			return
		end

		if get_files_count() > 1 then
			vim.opt.winbar = winbar_format
			return
		end
		vim.opt.winbar = nil
	end,
})
