return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		V.g.nvim_tree_width_allow_resize = 1

		-- following options are the default
		require("nvim-tree").setup({
			auto_reload_on_write = true,
			-- disables netrw completely
			disable_netrw = true,
			-- hijack netrw window on startup
			hijack_netrw = true,
			-- open the tree when running this setup function
			hijack_unnamed_buffer_when_opening = false,
			-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
			open_on_tab = false,
			-- hijack the cursor in the tree to put it at the start of the filename
			hijack_cursor = false,
			-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
			update_cwd = false,
			-- show lsp diagnostics in the signcolumn
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
			update_focused_file = {
				-- enables the feature
				enable = true,
				-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
				-- only relevant when `update_focused_file.enable` is true
				update_cwd = false,
				-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
				-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
				ignore_list = {},
			},
			-- configuration options for the system open command (`s` in the tree by default)
			system_open = {
				-- the command to run this, leaving nil should work in most cases
				cmd = nil,
				-- the command arguments as a list
				args = {},
			},
			view = {
				-- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
				width = {
					min = 30,
					max = -1,
					-- padding = 1
				},
				-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
				side = "left",
				-- if true the tree will resize itself after opening a file
				signcolumn = "yes",
			},
			git = {
				ignore = false,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				highlight_opened_files = "name",
				group_empty = true,
				highlight_git = true,
				root_folder_modifier = ":t",
				icons = {
					webdev_colors = true,
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						git = {
							unstaged = "",
							staged = "",
							unmerged = "",
							renamed = "󰏬",
							untracked = "󰀧",
							deleted = "",
							ignored = "󰿦",
						},
					},
				},
			},
		})
	end,
}
