default_parsers = {
	"vim",
	"php",
	"java",
	"kotlin",
	"json",
	"css",
	"scss",
	"toml",
	"lua",
	"make",
	"vue",
	"jsonc",
	"yaml",
	"html",
	"tsx",
	"dart",
	"org",
	"rst",
	"c_sharp",
	"go",
	"c",
	"scheme",
	"http",
	"hjson",
	"jsdoc",
	"embedded_template",
	"python",
	"query",
	"regex",
	"markdown",
	"markdown_inline",
	"dockerfile",
	"rust",
	"dot",
	"eex",
	"bibtex",
	"javascript",
	"bash",
	"cmake",
	"cpp",
	"typescript",
	"json5",
}

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	-- build = ":TSUpdate",
	config = function()
		local overrides_ok, overrides = pcall(require, "user.treesitter.overrides")
		local filter_ok, filter = pcall(require, "utils.filter_tables")

		-- local defaults = require("user.treesitter.default_parsers")
		local defaults = default_parsers
		local ensure_installed = {}

		if overrides_ok and filter_ok then
			ensure_installed = filter(defaults, overrides.ignored)
		else
			ensure_installed = defaults
		end

		require("nvim-treesitter.configs").setup({
			ensure_installed = ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			highlight = {
				enable = true, -- false will disable the whole extension
			},
			indent = {
				enable = true,
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
				lsp_interop = {
					enable = true,
					border = "none",
					floating_preview_opts = {},
					peek_definition_code = {
						["<leader>df"] = "@function.outer",
						["<leader>dF"] = "@class.outer",
					},
				},
			},
			rainbow = {
				enable = true,
				colors = {
					"#69BBFF",
					"#FFD68A",
					"#B5E890",
					"#FF7A85",
					"#E48AFF",
					"#66D9E8",
				},
				max_file_lines = 1000,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				}
			}
		})
	end,
}
