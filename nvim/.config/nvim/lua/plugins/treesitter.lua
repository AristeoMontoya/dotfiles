local versions = require("settings.versions")
return {
	"nvim-treesitter/nvim-treesitter",
	commit = versions.nvim_treesitter,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", commit = versions.nvim_treesitter_textobjects },
		{ "nvim-treesitter/nvim-treesitter-context", commit = versions.nvim_treesitter_context },
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

		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "tskeywordoperator", value = { fg = "#d291e4" } },
			{ group = "tstypebuiltin", value = { fg = "#c678dd" } },
			{ group = "tsparameter", value = { fg = "#56b6c2" } },
			{ group = "tstitle", value = { fg = "#e5c07b" } },
			{ group = "tsinclude", value = { fg = "#d291e4" } },
			{ group = "tsrepeat", value = { fg = "#d291e4" } },
			{ group = "tserror", value = { bg = nil, fg = "#e06c75" } },
			{ group = "tstag", value = { bg = nil, fg = "#e06c75" } },
			{ group = "htmltstagattribute", value = { bg = nil, fg = "#e5c07b" } },
			{ group = "tscharacter", value = { fg = "#98c379" } },
			{ group = "tsmethod", value = { fg = "#61afef", bold = true } }, -- This was bolded
		})

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
		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			multiwindow = false, -- Enable multiwindow support.
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		})
	end,
}
