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
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig.configs")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

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
				--
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
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", function()
					vim.cmd("LspRestart")
				end, opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		---Returns a table containing the passed configuration
		---merged with user defined overrides
		---@param server_name string
		---@param settings table
		---@return table
		local function get_merged_configs(server_name, settings)
			local overrides = config_overrides[server_name]
			if overrides == nil then
				overrides = {}
			end
			local merged = vim.tbl_deep_extend("force", settings, overrides)
			return merged
		end

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

		configs.ccls = {
			default_config = {
				cmd = { "ccls" },
				filetypes = { "cpp", "c" },
				root_dir = function(fname)
					return require("lspconfig/util").root_pattern("compile_commands.json", ".ccls")(fname)
						or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
				end,
				single_file_support = false,
			},
		}
		-- Not handled by Mason
		lspconfig["ccls"].setup({
			capabilities = capabilities,
			init_options = {
				compilationDatabaseDirectory = "build",
				index = {
					threads = 2,
				},
				clang = {
					excludeArgs = { "-frounding-math" },
				},
			},
		})

		lspconfig["kulala_ls"].setup({
			capabilities = capabilities,
		})

		-- TODO: Find a more maintainable way to do this.
		-- Also update this to mason v2
		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				local settings = {
					capabilities = capabilities,
				}
				local merged = get_merged_configs(server_name, settings)
				lspconfig[server_name].setup(merged)
			end,
			["vimls"] = function()
				lspconfig["vimls"].setup({
					capabilities = capabilities,
				})
			end,
			["pyright"] = function()
				local settings = {
					capabilities = capabilities,
					settings = {
						pyright = {
							autoImportCompletion = true,
						},
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "openFilesOnly",
								useLibraryCodeForTypes = true,
								typeCheckingMode = "off",
							},
						},
					},
				}
				lspconfig["pyright"].setup(get_merged_configs("pyright", settings))
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				local settings = {
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				}
				lspconfig["emmet_ls"].setup(get_merged_configs("emmet_ls", settings))
			end,
			-- ["lua_ls"] = function()
			-- 	-- configure lua server (with special settings)
			-- 	local settings = {
			-- 		capabilities = capabilities,
			-- 		settings = {
			-- 			Lua = {
			-- 				runtime = {
			-- 					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			-- 					version = "LuaJIT",
			-- 					-- Setup your lua path
			-- 					path = vim.split(package.path, ";"),
			-- 				},
			-- 				-- make the language server recognize "vim" global
			-- 				diagnostics = {
			-- 					globals = { "vim" },
			-- 				},
			-- 				completion = {
			-- 					callSnippet = "Replace",
			-- 				},
			-- 				workspace = {
			-- 					-- Make the server aware of Neovim runtime files
			-- 					library = {
			-- 						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
			-- 						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			-- 						[vim.fn.stdpath("config") .. "/lua"] = true,
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 	}
			-- 	lspconfig["lua_ls"].setup(get_merged_configs("lua_ls", settings))
			-- end,
			["ts_ls"] = function()
				local settings = {
					capabilities = capabilities,
					javascript = {
						referencesCodeLens = {
							enabled = true,
						},
					},
					typescript = {
						referencesCodeLens = {
							enabled = true,
						},
					},
					root_dir = require("lspconfig/util").root_pattern(
						"package.json",
						"tsconfig.json",
						"jsconfig.json",
						".git"
					),
				}
				lspconfig["ts_ls"].setup(get_merged_configs("ts_ls", settings))
			end,
			["angularls"] = function()
				local settings = {
					capabilities = capabilities,
					root_dir = require("lspconfig/util").root_pattern(
						"package.json",
						"tsconfig.json",
						"jsconfig.json",
						".git"
					),
				}
				lspconfig["angularls"].setup(get_merged_configs("angularls", settings))
			end,
		})
	end,
}
