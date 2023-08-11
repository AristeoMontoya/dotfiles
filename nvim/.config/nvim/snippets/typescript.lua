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
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")

local get_node_text = V.treesitter.get_node_text

local is_spec = function()
	local name = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
	local match = string.find(name, "spec")
	return match ~= nil
end

local filename = function()
	return f(function(_args, snip)
		local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
		return name[1] or ""
	end)
end

ls.add_snippets("typescript", {
	s({
		trig = "it%s(.*)",
		regTrig = true,
		name = 'add test case'
	},
	fmt(
	[[
	it('{}', () => {{
		{}
	}});
	]], {
		f(function(_, snip)
			return snip.captures[1]
		end),
		i(0)
	}),
	{
		condition = is_spec * conds_expanded.line_end,
		show_condition = conds.make_condition(is_spec),
	}),
})
