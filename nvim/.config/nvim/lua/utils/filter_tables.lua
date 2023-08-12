return function (list_to_filter, reference_dict)
	local filtered = {}
	for _, element in pairs(list_to_filter) do
		-- For some reason the condition it's backwards, even on
		-- similar examples I find it is either like this or a negated inequity
		if reference_dict[element] == nil then
			table.insert(filtered, element)
		end
	end
	return filtered
end
