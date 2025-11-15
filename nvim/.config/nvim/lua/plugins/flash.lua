return {
	"folke/flash.nvim",
	commit = require("settings.versions").flash,
	event = "VeryLazy",
	opts = function()
		local hl_status, set_highlights = pcall(require, "utils.register_highlights") --- @type boolean, utils.RegisterHighlights
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "FlashMatch", value = { bg = "#66D9E8", fg = "#2c323c" } },
			{ group = "FlashLabel", value = { fg = "#C678DD", bg = "#2c323c" } },
		})
		return {
			highlight = {
				groups = {
					match = "FlashMatch",
					current = "FlashCurrent",
					backdrop = "FlashBackdrop",
					label = "FlashLabel",
				},
			},
		}
	end,
	keys = {
		{
			"s",
			mode = { "n", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
