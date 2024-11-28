return {
	"folke/which-key.nvim",
	commit = "b9684c6",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = true,
				nav = true,
				z = true,
				g = true
			}
		},
		win = {
			no_overlap = false,
			padding = { 1, 2 },
			title = false
		}
	},
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
