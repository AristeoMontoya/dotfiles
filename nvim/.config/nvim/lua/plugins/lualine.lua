return {
	"hoob3rt/lualine.nvim",
	commit = require("settings.versions").lualine,
	-- event = "InsertEnter",
	opts = function()
		local hl_status, set_highlights = pcall(require, "utils.register_highlights") --- @type boolean, utils.RegisterHighlights
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "lualine_y_diff_added_normal", value = { fg = "#98c379" } },
			{ group = "lualine_y_diff_added_inactive", value = { fg = "#98c379" } },
			{ group = "lualine_y_diff_modified_normal", value = { fg = "#56b6c2" } },
			{ group = "lualine_y_diff_modified_inactive", value = { fg = "#56b6c2" } },
			{ group = "lualine_y_diff_removed_normal", value = { fg = "#e06c75" } },
			{ group = "lualine_y_diff_removed_inactive", value = { fg = "#e06c75" } },
		})

		local function show_macro_recording()
			local recording_register = vim.fn.reg_recording()
			if recording_register == "" then
				return ""
			else
				return "Recording @" .. recording_register
			end
		end

		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				require("lualine").refresh({
					place = { "statusline" },
				})
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				-- This is going to seem really weird!
				-- Instead of just calling refresh we need to wait a moment because of the nature of
				-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
				-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
				-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
				-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
				local timer = vim.loop.new_timer()
				timer:start(
					50,
					0,
					vim.schedule_wrap(function()
						require("lualine").refresh({
							place = { "statusline" },
						})
					end)
				)
			end,
		})

		return {
			options = {
				theme = "onedark",
				section_separators = { nil },
				component_separators = { "|" },
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
					{
						"macro-recording",
						fmt = show_macro_recording,
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 4,
						shorting_target = 40,
					},
				},
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
						colored = true,
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 4,
						shorting_target = 40,
					},
				},
				lualine_x = { "location" },
				lualine_y = {},
			},
		}
	end,
}
