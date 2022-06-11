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

local get_node_text = vim.treesitter.get_node_text

local function get_filename()
	return V.fn.expand('%:t:r')
end

ls.add_snippets(
"java", {
	s("psvm", fmt(
	[[
	public static void main(String[] args) {{
		{}
	}}
	]], { i(0) })),
	
	s("cbplate", fmt(
	[[
	public class {} {{
		{}
	}}
	]], { t(get_filename()), i(0) }
	))
})
