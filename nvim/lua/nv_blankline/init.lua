require("indent_blankline").setup {
	char = "▏",
	buftype_exclude = { "terminal", "help" },
	use_treesitter = true,
	show_trailing_blankline_indent = false,
	show_current_context = true,
 	context_patterns = {
		"declaration", "expression", "pattern", "primary_expression",
		"statement", "switch_body", "function"
	}
}

-- Autocomand porque es cargado bajo demanda
vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
