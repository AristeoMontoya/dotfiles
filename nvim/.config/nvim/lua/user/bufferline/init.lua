require('bufferline').setup {
	options = {
		view = "multiwindow",
		numbers = "ordinal",
		number = "none", -- buffer_id at index 1, ordinal at index 2
		icon = '▎',
		modified_icon = '●',
		left_trunc_marker = '',
		right_trunc_marker = '',
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		offsets = {{filetype = "NvimTree", text = "", text_align = "left" }},
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		show_duplicate_prefix = true,
		separator_style = "thin",
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		enforce_regular_tabs = false,
		always_show_bufferline = false,
	},
    highlights = {
        fill = {
            bg = '#353b45',
        },
        background = {
            fg = '#abb2bf',
            bg = '#353b45'
        },
        buffer_selected = {
            fg = '#98c379',
        },
        numbers = {
            bg = '#353b45',
        },
        hint = {
            fg = '#abb2bf',
            sp = '#c678dd',
            bg = '#353b45',
        },
        info = {
            fg = '#abb2bf',
            sp = '#c678dd',
            bg = '#353b45',
        },
        warning = {
            fg = '#E5C07B',
            sp = '#c678dd',
            bg = '#353b45',
        },
        error = {
            fg = '#e06c75',
            sp = '#c678dd',
            bg = '#353b45',
        },
        modified = {
            bg = '#353b45'
        },
        separator = {
            bg = '#353b45',
            fg = '#353b45'
        },
        indicator_selected = {
            fg = '#98c379',
        },
        duplicate = {
            bg = '#353b45'
        },
        duplicate_visible = {
            bg = '#282C34'
        },
        duplicate_selected = {
            bg = '#282C34'
        }
    }
}
