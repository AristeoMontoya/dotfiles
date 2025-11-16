local open_window_ok, get_window_count = pcall(require, "utils.count_open_windows")
if not open_window_ok then
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

local winbar_format =
	"%= %{%(nvim_get_current_win()==#g:actual_curwin) ? '%#WinBarDynamic#' : '%#WinBarDynamicNC#'%} %{%luaeval('Winbar.get_modified_symbol()')%} %t "

vim.api.nvim_create_autocmd({ "WinNew", "WinClosed" }, {
	group = vim.api.nvim_create_augroup("winbar_when_needed", { clear = true }),
	callback = function()
		--- Scheduling so the function runs after
		--- neovim is done updating the layout
		vim.schedule(function()
			if get_window_count(false) > 1 then
				vim.opt.winbar = winbar_format
			else
				vim.opt.winbar = nil
			end
		end)
	end,
})
