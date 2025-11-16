local versions = require("settings.versions")
return {
	"nvim-treesitter/nvim-treesitter",
	commit = versions.nvim_treesitter,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", commit = versions.nvim_treesitter_textobjects },
		{ "nvim-treesitter/nvim-treesitter-context", commit = versions.nvim_treesitter_context },
		{ "HiPhish/rainbow-delimiters.nvim", commit = versions.rainbow_delimiters },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local overrides_ok, overrides = pcall(require, "user.overrides.treesitter") --- @type boolean, config.TSParsers
		local filter_ok, filter = pcall(require, "utils.filter_tables")

		local defaults = require("defaults.treesitter.default_parsers") --- @type config.TSParsers
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

		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = "rainbow-delimiters.strategy.global",
				vim = "rainbow-delimiters.strategy.local",
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			priority = {
				[""] = 110,
				lua = 210,
			},
			highlight = {
				"RainbowDelimiterYellow",
				"RainbowDelimiterGreen",
				"RainbowDelimiterBlue",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
				"RainbowDelimiterRed",
			},
		}

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
			{ group = "RainbowDelimiterRed", value = { fg = "#E06C75" } }, -- This was bolded
			{ group = "RainbowDelimiterYellow", value = { fg = "#E5C07B" } }, -- This was bolded
			{ group = "RainbowDelimiterBlue", value = { fg = "#61AFEF" } }, -- This was bolded
			{ group = "RainbowDelimiterGreen", value = { fg = "#98C379" } }, -- This was bolded
			{ group = "RainbowDelimiterViolet", value = { fg = "#C678DD" } }, -- This was bolded
			{ group = "RainbowDelimiterCyan", value = { fg = "#56B6C2" } }, -- This was bolded
		})

		-- Incremental selection is not supported now.
		require("nvim-treesitter").install(ensure_installed)

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

		require("nvim-treesitter-textobjects").setup({
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
			-- Not sure if this is still supported after the new
			-- re-write. Leaving it here until I figure it out.
			lsp_interop = {
				enable = true,
				border = "none",
				floating_preview_opts = {},
				peek_definition_code = {
					["<leader>df"] = "@function.outer",
					["<leader>dF"] = "@class.outer",
				},
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = ensure_installed,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- keymaps
		-- You can use the capture groups defined in `textobjects.scm`
		vim.keymap.set({ "x", "o" }, "af", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "if", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ac", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ic", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
		end)
		-- You can also use captures from other query groups like `locals.scm`
		vim.keymap.set({ "x", "o" }, "as", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
		end)

		-- Parameter swap
		vim.keymap.set("n", "<leader>a", function()
			require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
		end)
		vim.keymap.set("n", "<leader>A", function()
			require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
		end)
	end,
}
