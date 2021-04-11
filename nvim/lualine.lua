require('lualine').setup {
	options = {
		theme = 'onedark',
		section_separators = { nil },
		component_separators = {'|'},
		extension = { 'fugitive' }
	},
	sections = {
		lualine_a = { {'mode', upper = true} },
		lualine_b = { {'branch', icon = ''} },
		lualine_c = { {'filename', file_status = true} },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'diff' },
		lualine_z = { 'location'  },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { {'branch', icon = ''} },
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = { 'diff' },
		lualine_z = {}
	}
}
