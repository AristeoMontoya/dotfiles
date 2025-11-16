--- Returns the count of open windows (splits)
--- @param use_all_tabs boolean: should count across all tabs?
--- @return integer window_count
local function count_open_windows(use_all_tabs)
	if use_all_tabs then
		local count = 0
		for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
			local wins = vim.api.nvim_tabpage_list_wins(tab)
			count = count + #wins
		end
		return count
	end
	local wins = vim.api.nvim_list_wins()
	return #wins
end

return count_open_windows
