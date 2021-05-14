require("buftabline").setup {
	modifier = ":t",
	index_format = "%d: ",
	padding = 1,
	icons = true,
	auto_hide = true,
	disable_commands = false,
	go_to_maps = true,
	kill_maps = false,
	next_indicator = ">",
	custom_command = nil,
	custom_map_prefix = nil,
	hlgroup_current = "TabLineSel",
	hlgroup_normal = "TabLineFill",
}
