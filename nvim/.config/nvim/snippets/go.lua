local ls = require("luasnip")

require("luasnip.session.snippet_collection").clear_snippets("go")

local snippet_from_nodes = ls.sn

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")

local get_node_text = V.treesitter.get_node_text

local function get_maps()
	local map_query = [[
    (
      short_var_declaration
      left: (expression_list
        (identifier) @map_identifier
      )
      right: (expression_list
        (type_conversion_expression
          type: (map_type)
        )
      )
    )
    (
      short_var_declaration
      left: (expression_list
        (identifier) @map_identifier
      )
      right: (expression_list
        (composite_literal
          type: (map_type)
        )
      )
    )
    (
      short_var_declaration
      left: (expression_list
        (identifier) @map_identifier
      )
      right: (expression_list
        (call_expression
          function: (identifier)
          arguments: (argument_list
            (map_type)
          )
        )
      )
    )
    ]]

	local parser = vim.treesitter.get_parser(0, "go")
	if not parser then
		return {} -- Return an empty table if Treesitter is not available
	end

	local tree = parser:parse()[1]
	local query = vim.treesitter.query.parse("go", map_query)

	local maps = {}
	for id, node, _ in query:iter_captures(tree:root(), 0, 0, -1) do
		table.insert(maps, vim.treesitter.get_node_text(node, 0))
	end

	return maps or {} -- Ensure it always returns a table
end

local function is_in_function()
	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return false
	end
	local expr = current_node

	while expr do
		if expr:type() == "function_declaration" or expr:type() == "method_declaration" then
			return true
		end
		expr = expr:parent()
	end
	return false
end

local function is_in_test_file()
	local filename = vim.fn.expand("%:p")
	return vim.endswith(filename, "_test.go")
end

local function is_in_test_function()
	return is_in_test_file() and is_in_function()
end

local in_test_file = {
	show_condition = is_in_test_file,
	condition = is_in_test_file,
}

local in_test_func = {
	show_condition = is_in_test_function,
	condition = is_in_test_function,
}

ls.add_snippets("go", {
	s(
		{
			trig = "ifmap",
			name = "if map contains",
			dscr = "inline checks if a map contains a value",
		},
		fmt(
			[[
        if {}, {} := {}[{}]; {} {{
            {}
        }}
        ]],
			{
				i(1),
				c(2, { t("ok"), i(2, "custom_ok") }),
				d(3, function()
					local maps = get_maps()
					if #maps == 0 then
						return sn(nil, { i(1, "map") }) -- Fallback insert node if no maps are found
					end

					return sn(nil, {
						c(
							1,
							vim.tbl_map(function(map)
								return t(map)
							end, maps)
						),
					})
				end, {}),
				i(4),
				rep(2),
				i(0),
			}
		)
	),
	s(
		{
			trig = "impl",
			name = "Implement interface",
		},
		fmt(
			[[
			// Run code action "Declare missing methods" on this
			var _ {} = {}{{}}
			]],
			{
				i(1, "Interface"),
				i(0, "Struct"),
			}
		)
	),
	s(
		{ trig = "paratest", dscr = "Paramaetric tests" },
		fmt(
			[[
			testCases := []struct {{
				{}
			}} {{
			// Test cases here
			}}
			for _, tc := range testCases {{
				t.Run(tc.name, func(t *testing.T) {{
					{}
				}})
			}}
			]],
			{ ls.i(1), ls.i(2) }
		),
		in_test_func
	),
})
