require("indent_blankline").setup {
	buftype_exclude = { "terminal", "help", "packer", "man", "lsp-installer", "nofile" },
	filetype_exclude = { "man", "packer" },
	use_treesitter = true,
	show_trailing_blankline_indent = false,
	show_current_context = true,
	context_patterns = {
		"declaration", "expression", "pattern", "primary_expression",
		"statement", "switch_body", "function"
	}
}

-- Autocomand porque es cargado bajo demanda
V.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
