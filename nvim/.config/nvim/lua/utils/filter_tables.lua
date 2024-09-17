return function(list_to_filter, reference_dict)
	local filtered = {}

	for _, element in pairs(list_to_filter) do
		if not vim.tbl_contains(reference_dict, element, {predicate = false}) then
			table.insert(filtered, element)
		end
	end
	return filtered
end
