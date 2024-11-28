return {
	"RRethy/vim-illuminate",
	commit = require("settings.versions").vim_illuminate,
	-- event = "InsertEnter",
	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			delay = 100,
			filetypes_denylist = {
				"NvimTree",
				"alpha",
				"help",
			},
			under_cursor = true,
		})
	end,
}
