require("settings.constants")

require("lualine").setup({
	options = {
		theme = "onedark",
		section_separators = { nil },
		component_separators = { "|" },
		extension = { "nvim-tree" },
	},
	sections = {
		lualine_a = { { "mode", upper = true } },
		lualine_b = {
			{
				"branch",
				icon = "",
			},
			{
				"diff",
				colored = true,
				color_added = "#98c379",
				color_modified = "#56b6c2",
				color_removed = "#e06c75",
			},
			{
				"diagnostics",
				error = "e06c75",
				warn = "#e5c07b",
				info = "56b6c2",
			},
		},
		lualine_c = { { "filename", file_status = true } },
		lualine_x = { "encoding", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {
			{ "branch", icon = "" },
			{
				"diff",
				colored = false,
			},
		},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
	},
})
