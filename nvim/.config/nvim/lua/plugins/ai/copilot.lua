local versions = require("settings.versions")
return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
		commit = versions.copilot_lsp,
	},
	commit = versions.copilot,
	cmd = "Copilot",
	event = "InsertEnter",
	enabled = require("utils.resolve_features")().ai,
	config = function()
		require("copilot").setup({})
	end,
}
