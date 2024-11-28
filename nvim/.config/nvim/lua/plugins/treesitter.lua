local versions = require("settings.versions")
return {
	"nvim-treesitter/nvim-treesitter",
	commit = versions.nvim_treesitter,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", commit = versions.nvim_treesitter_textobjects },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local overrides_ok, overrides = pcall(require, "user.overrides.treesitter")
		local filter_ok, filter = pcall(require, "utils.filter_tables")

		local defaults = require("defaults.treesitter.default_parsers")
		local ensure_installed = {}

		if overrides_ok and filter_ok then
			ensure_installed = filter(defaults, overrides)
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
					node_incremental = "<return>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
