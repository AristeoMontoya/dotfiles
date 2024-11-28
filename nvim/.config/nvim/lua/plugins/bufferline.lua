local versions = require("settings.versions")
return {
	"akinsho/bufferline.nvim",
	commit = versions.bufferline,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", commit = versions.nvim_web_devicons },
	},
	opts = function()
		-- Unable to require inline inside config
		-- So I made this a function and I was able to require
		-- bufferline.groups that way.
		local buffgroups = require("bufferline.groups")
		return {
			options = {
				groups = {
					items = {
						buffgroups.builtin.pinned:with({ icon = "󰐃 " }),
					},
				},
				view = "multiwindow",
				numbers = "ordinal",
				number = "none", -- buffer_id at index 1, ordinal at index 2
				icon = "▎",
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, _, _)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				offsets = { { filetype = "NvimTree", text = "", text_align = "left" } },
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
					bg = "#353b45",
				},
				background = {
					fg = "#abb2bf",
					bg = "#353b45",
				},
				buffer_visible = {
					bg = "none",
				},
				buffer_selected = {
					fg = "#98c379",
					bg = "none",
					bold = true,
					italic = true,
				},
				numbers = {
					bg = "#353b45",
				},
				hint = {
					fg = "#abb2bf",
					sp = "#c678dd",
					bg = "#353b45",
				},
				info = {
					fg = "#abb2bf",
					sp = "#c678dd",
					bg = "#353b45",
				},
				warning = {
					fg = "#E5C07B",
					sp = "#c678dd",
					bg = "#353b45",
				},
				error = {
					fg = "#e06c75",
					sp = "#c678dd",
					bg = "#353b45",
				},
				modified = {
					bg = "#353b45",
				},
				separator = {
					bg = "#353b45",
					fg = "#98c379",
				},
				indicator_visible = {
					fg = "#98c379",
					bg = "none",
				},
				indicator_selected = {
					fg = "#98c379",
					bg = "none",
				},
				duplicate = {
					bg = "#353b45",
					italic = true,
				},
				duplicate_visible = {
					bg = "#282C34",
				},
				duplicate_selected = {
					bg = "#282C34",
				},
				numbers_visible = {
					-- fg = "<colour-value-here>",
					bg = "none",
				},
				numbers_selected = {
					-- fg = "<colour-value-here>",
					bg = "none",
					bold = true,
					italic = true,
				},
				diagnostic = {
					-- fg = "<colour-value-here>",
					bg = "#00ff00",
				},
				diagnostic_visible = {
					-- fg = "<colour-value-here>",
					bg = "#353b45",
				},
				diagnostic_selected = {
					-- fg = "<colour-value-here>",
					bg = "none",
					bold = true,
					italic = true,
				},
				hint_visible = {
					-- fg = "<colour-value-here>",
					bg = "none",
				},
				hint_selected = {
					-- fg = "#353b45",
					bg = "none",
					bold = true,
					italic = true,
				},
				hint_diagnostic = {
					fg = "#a6daff",
					bg = "#353b45",
				},
				hint_diagnostic_visible = {
					bg = "none",
				},
				hint_diagnostic_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				info_visible = {
					bg = "none",
				},
				info_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				info_diagnostic = {
					fg = "#56B6C2",
					bg = "#353b45",
				},
				info_diagnostic_visible = {
					fg = "#56B6C2",
					bg = "none",
				},
				info_diagnostic_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				warning_visible = {
					bg = "none",
				},
				warning_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				warning_diagnostic = {
					fg = "#E5C07B",
					bg = "#353b45",
				},
				warning_diagnostic_visible = {
					fg = "#E5C07B",
					bg = "none",
				},
				warning_diagnostic_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				error_visible = {
					fg = "#E06C75",
					bg = "none",
				},
				error_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				error_diagnostic = {
					fg = "#E06C75",
					bg = "#353b45",
				},
				error_diagnostic_visible = {
					fg = "#E06C75",
					bg = "none",
				},
				error_diagnostic_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				modified_visible = {
					bg = "#353b45",
				},
				modified_selected = {
					bg = "none",
				},
				separator_selected = {
					bg = "none",
				},
				separator_visible = {
					bg = "#353b45",
				},
				pick_selected = {
					bg = "none",
					bold = true,
					italic = true,
				},
				pick_visible = {
					bg = "none",
					bold = true,
					italic = true,
				},
				pick = {
					bg = "#353b45",
					bold = true,
					italic = true,
				},
				offset_separator = {
					bg = "#353b45",
				},
				trunc_marker = {
					fg = "#61AFEF",
					bg = "#353b45",
				},
			},
		}
	end,
}
