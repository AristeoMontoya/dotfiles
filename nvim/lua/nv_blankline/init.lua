require("indent_blankline").setup {
	char = "▏",
	buftype_exclude = { "terminal" },
	use_treesitter = true,
	show_current_context = true,
	context_patterns = {
		"declaration", "expression", "pattern", "primary_expression",
		"statement", "switch_body", "function"
	}
}
