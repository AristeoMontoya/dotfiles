return {
	"RRethy/vim-illuminate",
	commit = "5eeb795",
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
