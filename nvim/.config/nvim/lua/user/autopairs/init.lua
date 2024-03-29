require('nvim-autopairs').setup{
	disable_filetype = { "TelescopePrompt" },
	disable_in_macro = true,
	disable_in_visualblock = false,
	ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
	enable_moveright = true,
	enable_afterquote = true,
	enable_check_bracket_line = true,
	check_ts = true,
	map_bs = true,
	map_c_h = false,
	map_c_w = false
}
