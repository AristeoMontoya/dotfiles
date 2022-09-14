local ls = require "luasnip"

require("luasnip.session.snippet_collection").clear_snippets "go"

-- local snippet = ls.s
local snippet_from_nodes = ls.sn

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = V.treesitter.get_node_text

ls.add_snippets(
"python", {
	s("main", fmt(
	[[
	if __name__ == '__main__':
		{}
	]], { i(0) })),
})
