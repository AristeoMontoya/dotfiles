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
	local tree = parser:parse()[1]
	local query = vim.treesitter.query.parse("go", map_query)

	local maps = {}
	for id, node, _ in query:iter_captures(tree:root(), 0, 0, -1) do
		table.insert(maps, vim.treesitter.get_node_text(node, 0))
	end
	return maps
end

ls.add_snippets("go", {
	s(
		"ifmap",
		fmt(
			[[
        if {}, {} := {}[{}]; {} {{
            {}
        }}
        ]],
			{
				i(1),
				c(2, { t("ok"), i(2, "custom_ok") }),
				c(
					3,
					vim.tbl_map(function(map)
						return t(map)
					end, get_maps())
				),
				i(4),
				rep(2),
				i(0),
			}
		)
	),
})
