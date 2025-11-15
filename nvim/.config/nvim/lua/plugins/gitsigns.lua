local versions = require("settings.versions")
return {
	"lewis6991/gitsigns.nvim",
	commit = versions.gitsigns,
	dependencies = {
		{ "nvim-lua/plenary.nvim", commit = versions.plenary },
	},
	-- event = "InsertEnter",
	opts = function()
		local hl_status, set_highlights = pcall(require, "utils.register_highlights") --- @type boolean, utils.RegisterHighlights
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "GitGutterAdd", value = { bg = nil, fg = "#98c379" } },
			{ group = "GitGutterChange", value = { bg = nil, fg = "#61afef" } },
			{ group = "GitGutterDelete", value = { bg = nil, fg = "#e06c75" } },
			{ group = "GitGutterChangeDelete", value = { bg = nil, fg = "#c678dd" } },
			{ group = "GitGutterAddLine", value = { bg = nil, fg = "#98c379" } },
			{ group = "GitGutterChangeLine", value = { bg = nil, fg = "#61afef" } },
			{ group = "GitGutterDeleteLine", value = { bg = nil, fg = "#e06c75" } },
			{ group = "GitGutterChangeDeleteLine", value = { bg = nil, fg = "#c678dd" } },
		})

		return {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "│" },
			},
			signs_staged = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "│" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = true,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 500,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nV_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					V.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", function()
					if V.wo.diff then
						vim.cmd.normal({ "]]", bang = true })
					else
						gs.nav_hunk("next")
					end
				end)

				map("n", "[h", function()
					if V.wo.diff then
						vim.cmd.normal({ "[[", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end)

				-- Actions
				map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
				map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
				map("n", "<leader>gu", gs.undo_stage_hunk)
				map("n", "<leader>gp", gs.preview_hunk)
				map("n", "<leader>gd", gs.diffthis)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		}
	end,
}
