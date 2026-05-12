return {
	"folke/which-key.nvim",
	commit = require("settings.versions").which_key,
	event = "VeryLazy",
	opts = function()
		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "WhichKeySeparator", value = { fg = "#61AFEF" } },
		})

		local wk = require("which-key")

		wk.add({
			{ "<leader>i", group = "ai" },
			{ "<leader>b", group = "buffers" },
			{ "<leader>d", group = "debug" },
			{ "<leader>f", group = "find" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>m", group = "bookmarks" },
			{ "<leader>R", group = "Requests" },
			{ "<leader>s", group = "split" },
			{ "<leader>t", group = "test" },
			{ "<leader>v", group = "verify grammar" },
			{ "<leader><leader>", group = "move buffer" },
		})

		return {
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			win = {
				no_overlap = false,
				padding = { 1, 2 },
				title = false,
			},
		}
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
