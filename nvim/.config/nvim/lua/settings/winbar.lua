local open_window_ok, get_window_count = pcall(require, "utils.count_open_windows")
if not open_window_ok then
	return
end

-- Patterns matched against filetype with string.find (regex)
-- Uses lua patterns, so things like "-" need to be scaped with "%-"
-- Need escaping: "( ) . % + - * ? [ ] ^ $"
local ignored_ft_patterns = {
	".*kulala.*",
	"minifiles",
	"snacks.*",
	"cmdline",
	"trouble",
}

local ignored_buftypes = {
	["nofile"] = true,
	["nowrite"] = true,
	["quickfix"] = true,
	["terminal"] = true,
	["prompt"] = true,
}

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

local function should_show_winbar(win)
	local buf = vim.api.nvim_win_get_buf(win)
	local ft = vim.bo[buf].filetype
	local bt = vim.bo[buf].buftype

	if ignored_buftypes[bt] then
		return false
	end

	return not vim.iter(ignored_ft_patterns):any(function(pattern)
		return ft:find("^" .. pattern .. "$") ~= nil
	end)
end

local function update_winbars()
	local show = get_window_count(false) > 1
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if should_show_winbar(win) then
			vim.wo[win].winbar = show and winbar_format or ""
		end
		-- Ignored filetypes: we deliberately leave vim.wo[win].winbar alone,
		-- so kulala (and others) can manage their own winbar freely.
	end
end

vim.api.nvim_create_autocmd({ "WinNew", "WinClosed" }, {
	group = vim.api.nvim_create_augroup("winbar_when_needed", { clear = true }),
	callback = function()
		vim.schedule(update_winbars)
	end,
})
