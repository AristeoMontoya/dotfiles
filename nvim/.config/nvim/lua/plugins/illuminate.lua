return {
	"RRethy/vim-illuminate",
	commit = require("settings.versions").vim_illuminate,
	-- event = "InsertEnter",
	config = function()
		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "illuminatedWord", value = { bg = "#313640" } },
			{ group = "illuminatedWordRead", value = { bg = "#313640" } }, -- these ones had gui=none
			{ group = "illuminatedWordWrite", value = { bg = "#313640" } }, -- these ones had gui=none
			{ group = "illuminatedWordText", value = { bg = "#313640" } }, -- these ones had gui=none
		})

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
