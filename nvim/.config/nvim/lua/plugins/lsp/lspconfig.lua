local versions = require("settings.versions")
return {
	"neovim/nvim-lspconfig",
	commit = versions.nvim_lspconfig,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp", commit = versions.cmp_nvim_lsp },
		{ "antosha417/nvim-lsp-file-operations", config = true, commit = versions.nvim_lsp_file_operations },
		{ "folke/lazydev.nvim", ft = "lua", commit = versions.lazydev },
		{ "rmagatti/goto-preview", config = true, commit = versions.goto_preview },
	},
	config = function()

		local keymap = vim.keymap -- for conciseness

		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		-- TODO: Move this to lsp dir itself
		local config_overrides_ok, config_overrides = pcall(require, "user.overrides.lsp.configs") --- @type boolean, table
		-- Setting an empty table to merge
		if not config_overrides_ok then
			config_overrides = {}
		end

		set_highlights({
			{ group = "DiagnosticError", value = { fg = "#E06C75" } },
			{ group = "DiagnosticErrorLine", value = { bg = "#433943" } },
			{ group = "DiagnosticWarn", value = { fg = "#e5c07b" } },
			{ group = "DiagnosticWarnLine", value = { bg = "#434444" } },
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", function()
					require("snacks").picker.lsp_references({ jump = { reuse_win = true } })
				end, opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", function()
					require("snacks").picker.lsp_definitions({ jump = { reuse_win = true } })
				end, opts) -- show lsp definitions

				opts.desc = "Preview LSP definitions"
				keymap.set("n", "gp", function()
					require("goto-preview").goto_preview_definition()
				end, opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", function()
					require("snacks").picker.lsp_implementations({ jump = { reuse_win = true } })
				end, opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", function()
					require("snacks").picker.lsp_type_definitions({ jump = { reuse_win = true } })
				end, opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "List file symbols"
				keymap.set({ "n", "v" }, "<leader>ls", function()
					require("snacks").picker.lsp_symbols()
				end, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Find diagnostics for current buffer"
				keymap.set("n", "<leader>fd", function()
					Snacks.picker.diagnostics_buffer()
				end, opts) -- show  diagnostics for file

				opts.desc = "Find diagnostics for project"
				keymap.set("n", "<leader>fD", function()
					Snacks.picker.diagnostics()
				end, opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>ll", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function() vim.diagnostic.jump({count = -1, float = false}) end, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function() vim.diagnostic.jump({count = 1, float = false}) end, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", function()
					vim.cmd("LspRestart")
				end, opts) -- mapping to restart lsp if necessary
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		}
		vim.diagnostic.config({
			signs = {
				text = signs,
				linehl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
					[vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
				},
			},
			underline = true,
			virtual_lines = {
				current_line = true,
			},
		})

		vim.lsp.enable("ccls")
	end,
}
