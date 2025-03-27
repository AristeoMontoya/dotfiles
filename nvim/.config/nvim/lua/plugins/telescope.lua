local versions = require("settings.versions")
return {
	"nvim-telescope/telescope.nvim",
	commit = versions.telescope,
	-- event = "InsertEnter",
	dependencies = {
		{ "nvim-lua/popup.nvim", commit = versions.popup },
		{ "nvim-lua/plenary.nvim", commit = versions.plenary },
		{ "nvim-telescope/telescope-ui-select.nvim", commit = versions.telescope_ui_select },
	},
	config = function()
		local actions = require("telescope.actions")
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		-- Telescope
		opts.desc = "Find files"
		map("n", "<leader>ff", ":Telescope find_files<CR>", opts)

		opts.desc = "Find grep"
		map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

		opts.desc = "Find buffers"
		map("n", "<leader>fb", ":Telescope buffers<CR>", opts)

		opts.desc = "Find help"
		map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

		local select_one_or_multi = function(prompt_bufnr)
			local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
			local multi = picker:get_multi_selection()
			if not vim.tbl_isempty(multi) then
				require("telescope.actions").close(prompt_bufnr)
				for _, j in pairs(multi) do
					if j.path ~= nil then
						vim.cmd(string.format("%s %s", "edit", j.path))
					end
				end
			else
				require("telescope.actions").select_default(prompt_bufnr)
			end
		end

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<esc>"] = actions.close,
						["<CR>"] = select_one_or_multi,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
				prompt_prefix = "> ",
				selection_caret = "> ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "descending",
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						mirror = false,
						prompt_position = "top",
						width = 0.75,
						results_height = 20,
						results_width = 0.8,
						preview_cutoff = 40,
					},
				},
				path_display = {
					"truncate",
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = {
					"%.class",
				},
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			},
			-- extensions = {
			-- 	["ui-select"] = {
			-- 		require("telescope.themes").get_dropdown({
			-- 			-- even more opts
			-- 		}),
			-- 	},
			-- },
		})

		require("telescope").load_extension("ui-select")
	end,
}
