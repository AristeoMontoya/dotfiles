local versions = require("settings.versions")
return {
	"TheNoeTrevino/haunt.nvim",
	commit = versions.haunt,
	-- default config: change to your liking, or remove it to use defaults
	---@class HauntConfig
	opts = {
		sign = "",
		sign_hl = "DiagnosticInfo",
		virt_text_hl = "HauntAnnotation", -- links to DiagnosticVirtualTextHint
		annotation_prefix = " 󰆉 ",
		annotation_suffix = "",
		line_hl = nil,
		virt_text_pos = "eol",
		data_dir = nil,
		per_branch_bookmarks = true,
		picker = "auto", -- "auto", "snacks", "telescope", or "fzf"
		picker_keys = { -- picker agnostic, we got you covered
			delete = { key = "d", mode = { "n" } },
			edit_annotation = { key = "a", mode = { "n" } },
		},
	},
	-- recommended keymaps, with a helpful prefix alias
	init = function()
		local haunt = require("haunt.api")
		local haunt_picker = require("haunt.picker")
		local map = vim.keymap.set
		local prefix = "<leader>m"

		local function get_bookmark_root()
			local project_root = require("utils.project_resolver").get({ use_lsp = true, parents = 1 })

			if not project_root then
				return
			end
			local data_dir = vim.fn.stdpath("data") .. "/haunt/"
			local project_bookmarks = data_dir .. project_root .. "/bookmarks"
			vim.notify("Bookmark directory: " .. project_bookmarks, vim.log.levels.INFO)
			require("haunt.api").change_data_dir(project_bookmarks)
		end

		vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
			callback = get_bookmark_root,
		})

		-- annotations
		map("n", prefix .. "a", function()
			haunt.annotate()
		end, { desc = "Annotate" })

		map("n", prefix .. "t", function()
			haunt.toggle_annotation()
		end, { desc = "Toggle annotation" })

		map("n", prefix .. "T", function()
			haunt.toggle_all_lines()
		end, { desc = "Toggle all annotations" })

		map("n", prefix .. "d", function()
			haunt.delete()
		end, { desc = "Delete bookmark" })

		map("n", prefix .. "C", function()
			haunt.clear_all()
		end, { desc = "Delete all bookmarks" })

		-- move
		map("n", "[m", function()
			haunt.prev()
		end, { desc = "Previous bookmark" })

		map("n", "]m", function()
			haunt.next()
		end, { desc = "Next bookmark" })

		-- picker
		map("n", "<leader>fm", function()
			haunt_picker.show()
		end, { desc = "Find bookmarks" })

		-- quickfix
		map("n", prefix .. "q", function()
			haunt.to_quickfix()
		end, { desc = "Send Hauntings to QF Lix (buffer)" })

		map("n", prefix .. "Q", function()
			haunt.to_quickfix({ current_buffer = true })
		end, { desc = "Send Hauntings to QF Lix (all)" })

		-- yank
		map("n", prefix .. "y", function()
			haunt.yank_locations({ current_buffer = true })
		end, { desc = "Send Hauntings to Clipboard (buffer)" })

		map("n", prefix .. "Y", function()
			haunt.yank_locations()
		end, { desc = "Send Hauntings to Clipboard (all)" })
	end,
}
