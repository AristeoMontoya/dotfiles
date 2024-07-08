return {
	"nvimdev/lspsaga.nvim",
	-- event = "InsertEnter",
	opts = {
		lightbulb = {
			enable = false,
		},
		symbol_in_winbar = {
			enable = true,
			separatos = " > ",
			show_file = false,
			color_mode = true,
		},
		rename = {
			in_select = false,
		},
	},
}
