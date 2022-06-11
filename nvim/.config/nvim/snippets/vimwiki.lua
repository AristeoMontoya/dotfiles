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

local function current_date()
	return os.date('%A %d de %B de %Y')
end

ls.add_snippets(
"vimwiki", {
	s("link", fmt(
	[[
	[{}]({})
	]], { i(1, "text"), i(0, "reference") })),
	
	s("idea", fmt(
	[[
	# Idea principal

	# Posibles características

	# Pendientes

	# Hallazgos

	# Notas
	{}
	]], { i(0) }
	)),

	s("reunion", fmt(
	[[
	# Tareas obtenidas

	# Apuntes de {}

	# Post-Reunión
	]], { t(current_date()) }
	)),

	s("100doc", fmt(
	[[
	# Día {} - {}
	## Tecnologías
	- {}

	## Resumen
	{}
	]], { i(1, 'número'), t(current_date()), i(2, 'tecnologías'), i(0) }
	)),

	s("horaActual", fmt("{}", {t(os.date('%H:%M'))})),

	s("diary", fmt(
	[[
	# {}
	## Tareas para hoy

	# Notas
	{}
	]], { t(os.date('%A %d, %B %Y')), i(0) }
	)),

	s("fechaNarutal", fmt('{}', {t(current_date())})),

	s("inlineCode", fmt('`{}`', {i(0)})),

	s("codeBlock", fmt(
	[[
	```{}
	{}
	```
	]], { i(1, 'lenguaje'), i(0) }
	))
})
