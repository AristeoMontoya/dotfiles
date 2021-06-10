require('bufferline').setup {
	options = {
		view = "multiwindow",
		numbers = "ordinal",
		number_style = "none", -- buffer_id at index 1, ordinal at index 2
		indicator_icon = '▎',
		modified_icon = '●',
		left_trunc_marker = '',
		right_trunc_marker = '',
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = false,
		offsets = {{filetype = "NvimTree", text = "", text_align = "left" }},
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		separator_style = "thin",
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		enforce_regular_tabs = true,
		always_show_bufferline = false,
	}
}
