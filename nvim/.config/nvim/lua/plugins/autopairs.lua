return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			disable_filetype = { "TelescopePrompt" },
			disable_in_macro = true,
			disable_in_visualblock = false,
			ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
			enable_moveright = true,
			enable_afterquote = true,
			enable_check_bracket_line = true,
			check_ts = true,
			map_bs = true,
			map_c_h = false,
			map_c_w = false,
		})

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
