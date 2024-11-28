return {
	"lukas-reineke/indent-blankline.nvim",
	commit = "7871a88",
	main = "ibl",
	opts = {
		scope = {
			enabled = true,
			show_start = true,
			show_end = false,
			injected_languages = false,
			highlight = { "Label" },
			priority = 500,
		},
		exclude = {
			filetypes = {
				"man",
				"packer",
			},
			buftypes = {
				"terminal",
				"help",
				"packer",
				"man",
				"lsp-installer",
				"nofile",
			},
		},
	},
}
