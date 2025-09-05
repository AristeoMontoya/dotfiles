return {
	"mistweaverco/kulala.nvim",
	commit = require("settings.versions").kulala,
	keys = {
		{ "<leader>Rs", desc = "Send request" },
		{ "<leader>Ra", desc = "Send all requests" },
		{ "<leader>Rb", desc = "Open scratchpad" },
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>R",
		kulala_keymaps_prefix = "",
		ui = {
			split_direction = "horizontal",
			win_opts = {
				wo = {
					foldmethod = "manual" -- Why is auto fold by default?
				}
			}
		}
	},
}
