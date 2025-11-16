local versions = require("settings.versions")
return {
	"LintaoAmons/bookmarks.nvim",
	commit = versions.bookmarks,
	dependencies = {
		{ "kkharji/sqlite.lua", commit = versions.sqlite_lua },
		{ "ahmedkhalf/project.nvim", commit = versions.project },
	},
	opts = function()
		require("project_nvim").setup({
			manual_mode = false,
			detection_methods = { "lsp", "pattern" },
			patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "gradlew" },
			ignore_lsp = {},
			exclude_dirs = {},
			show_hidden = false,
			silent_chdir = true,
			scope_chdir = "global",
			datapath = vim.fn.stdpath("data"),
		})
		--
		local find_or_create_project_bookmark_group = function()
			local project_root = require("project_nvim.project").get_project_root()
			if not project_root then
				return
			end

			local project_name = string.gsub(project_root, "^" .. os.getenv("HOME") .. "/", "")
			local Service = require("bookmarks.domain.service")
			local Repo = require("bookmarks.domain.repo")
			local bookmark_list = nil

			for _, bl in ipairs(Repo.find_lists()) do
				if bl.name == project_name then
					bookmark_list = bl
					break
				end
			end

			if not bookmark_list then
				bookmark_list = Service.create_list(project_name)
			end
			Service.set_active_list(bookmark_list.id)
			require("bookmarks.sign").safe_refresh_signs()
		end

		vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
			group = vim.api.nvim_create_augroup("BookmarksGroup", {}),
			pattern = { "*" },
			callback = find_or_create_project_bookmark_group,
		})

		return {}
	end,
	init = function()
		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "BookmarksNvimSign", value = { bg = nil, fg = "#61AFEF", force = true} },
		})
	end,
	keys = {
		{
			"<leader>mt",
			function()
				vim.cmd("BookmarksMark")
			end,
			desc = "Toggle bookmark",
		},
		{
			"<leader>ml",
			function()
				vim.cmd("BookmarksList")
			end,
			desc = "Open bookmarks lists",
		},
		{
			"<leader>mc",
			function()
				vim.cmd("BookmarksDesc")
			end,
			desc = "Open bookmarks lists",
		},
		{
			"<leader>mi",
			function()
				vim.cmd("BookmarksInfoCurrentBookmark")
			end,
			desc = "Open bookmarks lists",
		},
		{
			"<leader>fm",
			function()
				vim.cmd("BookmarksGoto")
			end,
			desc = "Find bookmarks",
		},
	},
}
