--- Takes two lists of strings (tables with no key) and filters from the
--- first list the elements from the second one.
---@alias utils.FilterTables fun(
---    list_to_filter: string[],  -- A list of elements to filter
---    reference_dict: string[],  -- List containing the elements to filter out
---): string[]                    -- Filtered table without elements in reference_dict

--- @type utils.FilterTables
return function(list_to_filter, reference_dict)
	local filtered = {}

	for _, element in pairs(list_to_filter) do
		if not vim.tbl_contains(reference_dict, element, {predicate = false}) then
			table.insert(filtered, element)
		end
	end
	return filtered
end
