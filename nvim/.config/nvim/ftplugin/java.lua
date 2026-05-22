-- TS Highlights
vim.api.nvim_set_hl(0, "@variable.member.java", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@variable.parameter.java", { link = "Constant" })
vim.api.nvim_set_hl(0, "@import.path.java", { link = "Constant" })
vim.api.nvim_set_hl(0, "@attribute.java", { link = "Type" })
vim.api.nvim_set_hl(0, "@package.java", { link = "Type" })

-- LSP Highlights
vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.java", { link = "Constant" })

local ns = vim.api.nvim_create_namespace("java_path_params")

local MAPPING_ANNOTATIONS = {
	Path = true,
	GetMapping = true,
	PostMapping = true,
	PutMapping = true,
	DeleteMapping = true,
	PatchMapping = true,
	RequestMapping = true,
}

local function unwrap(n)
	return type(n) == "table" and n[#n] or n
end

local function highlight_path_params(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "java")
	if not ok or not parser then
		return
	end

	local tree = parser:parse()[1]
	if not tree then
		return
	end

	local root = tree:root()

	-- Query to find string_fragment nodes inside the relevant annotations
	local query_src = [[
    (annotation
      name: (identifier) @_name
      arguments: (annotation_argument_list
        (string_literal
          (string_fragment) @frag)))

    (annotation
      name: (identifier) @_name
      arguments: (annotation_argument_list
        (element_value_pair
          value: (string_literal
            (string_fragment) @frag))))
  ]]

	local query = vim.treesitter.query.parse("java", query_src)

	for _, match, _ in query:iter_matches(root, bufnr, 0, -1) do
		local name_node, frag_node

		-- then in the loop:
		for id, node in pairs(match) do
			local cap = query.captures[id]
			if cap == "_name" then
				name_node = unwrap(node)
			end
			if cap == "frag" then
				frag_node = unwrap(node)
			end
		end

		if name_node and frag_node then
			local name_text = vim.treesitter.get_node_text(name_node, bufnr)

			if MAPPING_ANNOTATIONS[name_text] then
				local frag_text = vim.treesitter.get_node_text(frag_node, bufnr)
				local start_row, start_col = frag_node:start()

				-- Find every {param} in the fragment and highlight it
				local search_start = 1
				while true do
					local s, e = frag_text:find("{[^}]+}", search_start)
					if not s then
						break
					end

					vim.api.nvim_buf_set_extmark(bufnr, ns, start_row, start_col + s - 1, {
						end_col = start_col + e, -- e is already inclusive of `}`
						hl_group = "Constant",
						priority = 150, -- above treesitter default (100)
					})

					search_start = e + 1
				end
			end
		end
	end
end

-- Run on open and on every file change
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
	pattern = "*.java",
	callback = function(ev)
		highlight_path_params(ev.buf)
	end,
})
