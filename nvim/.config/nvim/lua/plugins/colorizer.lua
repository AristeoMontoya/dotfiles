return {
	"norcalli/nvim-colorizer.lua",
	commit = require("settings.versions").nvim_colorizer,
	event = "InsertEnter",
	opts = {
		"*",
		"!vimwiki",
		"!markdown",
	},
}
