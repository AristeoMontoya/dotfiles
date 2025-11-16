--- Takes two lists of strings (tables with no key) and filters from the
--- first list the elements from the second one.
--- @param list_to_filter string[]: A list of elements to filter
--- @param reference_dict string[]: List containing the elements to filter out
--- @return string[] filtered_list: Elements of list 1 withouth elements from list 2.
local function filter_tables(list_to_filter, reference_dict)
	local filtered = {}

	for _, element in pairs(list_to_filter) do
		if not vim.tbl_contains(reference_dict, element, {predicate = false}) then
			table.insert(filtered, element)
		end
	end
	return filtered
end

return filter_tables
