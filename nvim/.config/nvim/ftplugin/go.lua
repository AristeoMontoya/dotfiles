vim.api.nvim_set_hl(0, "@operator.go", { link = "Define" })
vim.api.nvim_set_hl(0, "@module.go", { link = "Type" })
vim.api.nvim_set_hl(0, "@variable.parameter.go", { link = "Constant" })
vim.api.nvim_set_hl(0, "@import.path.go", { link = "Type" })

local ns = vim.api.nvim_create_namespace("go_param_usages")
local function unwrap(n)
	return type(n) == "table" and n[#n] or n
end

local function highlight_param_usages(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "go")
	if not ok or not parser then
		return
	end

	local root = parser:parse()[1]:root()

	-- Grab every function/method and process it as a self-contained scope
	local fn_query = vim.treesitter.query.parse(
		"go",
		[[
    [
      (function_declaration  parameters: (parameter_list) @params body: (block) @body)
      (method_declaration    parameters: (parameter_list) @params body: (block) @body)
      (func_literal          parameters: (parameter_list) @params body: (block) @body)
    ]
  ]]
	)

	-- Collect all identifier nodes named `target` inside a given node
	local function collect_usages(scope_node, target)
		local usage_query = vim.treesitter.query.parse("go", "(identifier) @id")
		local results = {}
		for _, node in usage_query:iter_captures(scope_node, bufnr) do
			local n = unwrap(node)
			if vim.treesitter.get_node_text(n, bufnr) == target then
				results[#results + 1] = n
			end
		end
		return results
	end

	for _, match in fn_query:iter_matches(root, bufnr, 0, -1) do
		local params_node, body_node

		for id, node in pairs(match) do
			local cap = fn_query.captures[id]
			if cap == "params" then
				params_node = unwrap(node)
			end
			if cap == "body" then
				body_node = unwrap(node)
			end
		end

		if not params_node or not body_node then
			goto continue
		end

		-- Extract every parameter name from the parameter list
		local param_names = {}
		local param_query = vim.treesitter.query.parse(
			"go",
			[[
      (parameter_declaration name: (identifier) @param_name)
    ]]
		)
		for _, node in param_query:iter_captures(params_node, bufnr) do
			local n = unwrap(node)
			param_names[vim.treesitter.get_node_text(n, bufnr)] = true
		end

		-- For each param name, highlight all usages inside the body
		for name in pairs(param_names) do
			for _, usage_node in ipairs(collect_usages(body_node, name)) do
				local row, col, _, end_col = usage_node:range()
				vim.api.nvim_buf_set_extmark(bufnr, ns, row, col, {
					end_col = end_col,
					hl_group = "@variable.parameter.go",
					priority = 150,
				})
			end
		end

		::continue::
	end
end

-- 1. Debounce — don't run on every single keystroke, wait for a pause
local timer = vim.uv.new_timer()

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	buffer = vim.api.nvim_get_current_buf(),
	callback = function(ev)
		timer:stop()
		timer:start(
			150,
			0,
			vim.schedule_wrap(function()
				highlight_param_usages(ev.buf)
			end)
		)
	end,
})

-- BufEnter and BufWritePost can run immediately, no need to debounce those
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	buffer = vim.api.nvim_get_current_buf(),
	callback = function(ev)
		highlight_param_usages(ev.buf)
	end,
})

highlight_param_usages()
