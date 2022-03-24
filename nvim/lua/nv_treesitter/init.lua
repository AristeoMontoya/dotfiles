require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true -- false will disable the whole extension
	},
	indent = {
		enable = true
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				af = "@function.outer",
				["if"] = "@function.inner",
				ac = "@class.outer",
				ic = "@class.inner",
			},
		},
	},
	rainbow = {
		enable = true,
		colors = {
			'#69BBFF',
			'#FFD68A',
			'#B5E890',
			'#FF7A85',
			'#E48AFF',
			'#66D9E8'
		},
		max_file_lines = 1000
	}
}

require"nvim-treesitter.highlight"
local hlmap = V.treesitter.highlighter.hl_map
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
