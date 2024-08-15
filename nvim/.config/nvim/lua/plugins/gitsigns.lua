return {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- event = "InsertEnter",
	opts = {
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
	},
}
