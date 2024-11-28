return {
	"echasnovski/mini.files",
	commit = require("settings.versions").mini_files,
	opts = function()
		local keymap = vim.keymap
		local MiniFiles = require("mini.files")

		local minifiles_toggle = function()
			if not MiniFiles.close() then
				MiniFiles.open()
			end
		end

		keymap.set(
			"n",
			"<leader>fe",
			minifiles_toggle,
			{ silent = true, noremap = true, desc = "Open oil in a floating pane" }
		)

		return {
			-- Customization of shown content
			content = {
				-- Predicate for which file system entries to show
				filter = nil,
				-- What prefix to show to the left of file system entry
				prefix = nil,
				-- In which order to show file system entries
				sort = nil,
			},

			-- Module mappings created only inside explorer.
			-- Use `''` (empty string) to not create one.
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "L",
				go_out = "h",
				go_out_plus = "H",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},

			-- General options
			options = {
				-- Whether to delete permanently or move into module-specific trash
				permanent_delete = true,
				-- Whether to use for editing directories
				use_as_default_explorer = true,
			},

			-- Customization of explorer windows
			windows = {
				-- Maximum number of windows to show side by side
				max_number = math.huge,
				-- Whether to show preview of file/directory under cursor
				preview = false,
				-- Width of focused window
				width_focus = 50,
				-- Width of non-focused window
				width_nofocus = 15,
				-- Width of preview window
				width_preview = 25,
			},
		}
	end,
}
