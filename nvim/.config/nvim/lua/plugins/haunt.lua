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
		virt_text_pos = "above",
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

		-- Mirrors haunt's own HEAD watcher (haunt/watcher.lua): libuv
		-- fs_event (inotify), debounced, reload on change. That watcher
		-- only targets <gitdir>/HEAD though, so external writes to the
		-- bookmarks file itself (e.g. scripts/scripts/haunt_agent) never
		-- trigger a reload without this.
		local bookmarks_watch_handle = nil ---@type uv.uv_fs_event_t?
		local bookmarks_watch_debounce = nil ---@type uv.uv_timer_t?

		local function stop_bookmarks_watcher()
			if bookmarks_watch_debounce and not bookmarks_watch_debounce:is_closing() then
				bookmarks_watch_debounce:stop()
				bookmarks_watch_debounce:close()
			end
			bookmarks_watch_debounce = nil

			if bookmarks_watch_handle and not bookmarks_watch_handle:is_closing() then
				bookmarks_watch_handle:stop()
				bookmarks_watch_handle:close()
			end
			bookmarks_watch_handle = nil
		end

		local function schedule_bookmarks_reload()
			if bookmarks_watch_debounce and not bookmarks_watch_debounce:is_closing() then
				bookmarks_watch_debounce:stop()
				bookmarks_watch_debounce:close()
			end
			bookmarks_watch_debounce = vim.uv.new_timer()
			if not bookmarks_watch_debounce then
				return
			end
			bookmarks_watch_debounce:start(
				200,
				0,
				vim.schedule_wrap(function()
					bookmarks_watch_debounce = nil
					require("haunt.api").reload()
				end)
			)
		end

		local function watch_bookmarks_dir(dir)
			stop_bookmarks_watcher()
			vim.fn.mkdir(dir, "p")

			local handle = vim.uv.new_fs_event()
			if not handle then
				return
			end

			-- Non-recursive: only care about files landing directly in
			-- this project's bookmarks dir, not subdirs.
			local ok = pcall(handle.start, handle, dir, {}, function(err, filename)
				if err or (filename and not filename:match("%.json$")) then
					return
				end
				schedule_bookmarks_reload()
			end)

			if ok then
				bookmarks_watch_handle = handle
			else
				handle:close()
			end
		end

		local function get_bookmark_root()
			local project_root = require("utils.project_resolver").get({ use_lsp = true, parents = 0 })

			if not project_root then
				return
			end
			local data_dir = vim.fn.stdpath("data") .. "/haunt/"
			local project_bookmarks = data_dir .. project_root .. "/bookmarks"

			vim.defer_fn(function()
				vim.notify("Bookmark directory: " .. project_bookmarks, vim.log.levels.INFO)
			end, 300)
			require("haunt.api").change_data_dir(project_bookmarks)
			watch_bookmarks_dir(project_bookmarks)
		end

		vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
			callback = get_bookmark_root,
		})

		-- annotations
		map("n", prefix .. "a", function()
			haunt.annotate()
		end, { desc = "Annotate" })

		-- Appends a new "ai: " line instead of going through annotate()'s
		-- vim.fn.input(), which pre-fills the whole existing note as a
		-- single-line default and can't hold a real newline (it mangles
		-- one into a space on edit).
		map("n", prefix .. "A", function()
			local hstore = require("haunt.store")
			local hutils = require("haunt.utils")

			local bufnr = vim.api.nvim_get_current_buf()
			local line = vim.api.nvim_win_get_cursor(0)[1]
			local filepath = hutils.normalize_filepath(vim.api.nvim_buf_get_name(bufnr))
			local existing = hstore.get_bookmark_at_line(filepath, line)

			local addition = vim.fn.input({ prompt = " Append ai: " })
			if addition == "" then
				return
			end

			local note = existing and existing.note or ""
			local new_note = (note ~= "" and (note .. "\\n") or "") .. "ai: " .. addition
			haunt.annotate(new_note)
		end, { desc = "Append ai: line to annotation" })

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

		map("n", prefix .. "R", function()
			haunt.reload()
		end, { desc = "Reload bookmarks from disk" })

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
