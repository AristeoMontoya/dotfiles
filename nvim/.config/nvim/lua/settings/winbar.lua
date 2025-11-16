local call_ok, get_files_count = pcall(require, "utils.count_listed_files")
if not call_ok then
	return
end

Winbar = {}

Winbar.is_window_active = function(window)
	return window == vim.api.nvim_get_current_win()
end

Winbar.get_modified_symbol = function()
	if vim.bo.modified then
		return " ● "
	else
		return ""
	end
end

local winbar_format = "%= %{%(nvim_get_current_win()==#g:actual_curwin) ? '%#WinBarDynamic#' : '%#WinBarDynamicNC#'%} %{%luaeval('Winbar.get_modified_symbol()')%} %t "

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
