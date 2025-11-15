--- @class Highlight
--- @field id integer|nil
--- @field group string
--- @field value vim.api.keyset.highlight

--- Registers a list of `Highlight`
--- @alias utils.RegisterHighlights fun(
---    highlights: Highlight[],
--- )

--- @type utils.RegisterHighlights
return function (highligths)
	for _, highlight in pairs(highligths) do
		if highlight.id == nil then
			highlight.id = 0
		end
		if highlight.value == nil then
			vim.notify(
				"Group " .. highlight.group .. " doesnt have a definition",
				vim.log.levels.WARN
			)
			highlight.value = {}
		end
		vim.api.nvim_set_hl(
			highlight.id,
			highlight.group,
			highlight.value
		)
	end
end
