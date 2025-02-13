--- @class Highlight
--- @field id integer|nil
--- @field group string
--- @field value vim.api.keyset.highlight

--- @param highligths Highlight[]
--- Convenience function to allow each plugin
--- to define their own highlight
return function (highligths)
	for _, highlight in pairs(highligths) do
		if highlight.id == nil then
			highlight.id = 0
		end
		if highlight.value == nil then
			highlight.value = {}
		end
		vim.api.nvim_set_hl(
			highlight.id,
			highlight.group,
			highlight.value
		)
	end
end
