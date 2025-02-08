local versions = require("settings.versions")
return {
	"neovim/nvim-lspconfig",
	commit = versions.nvim_lspconfig,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp", commit = versions.cmp_nvim_lsp },
		{ "antosha417/nvim-lsp-file-operations", config = true, commit = versions.nvim_lsp_file_operations },
		{ "folke/lazydev.nvim", opts = {}, commit = versions.lazydev },
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

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				--
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "List file symbols"
				keymap.set({ "n", "v" }, "<leader>ls", "<cmd>Telescop lsp_document_symbols<CR>", opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Find diagnostics for current buffer"
				keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>ll", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = {
			Error = "",
			Warn = "",
			Hint = "",
			Info = "",
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

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

		-- lspconfig["jdtls"].setup({
		-- 	handlers = {
		-- 		-- By assigning an empty function, you can remove the notifications
		-- 		-- printed to the cmd
		-- 		["$/progress"] = function(_, result, ctx) end,
		-- 	},
		-- 	jdk = {
		-- 		auto_install = false,
		-- 	},
		-- 	java_test = {
		-- 		enable = false,
		-- 	},
		-- })

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["vimls"] = function()
				lspconfig["vimls"].setup({
					capabilities = capabilities,
				})
			end,
			["pyright"] = function()
				lspconfig["pyright"].setup({
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
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
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
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								-- Setup your lua path
								path = vim.split(package.path, ";"),
							},
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
							workspace = {
								-- Make the server aware of Neovim runtime files
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								},
							},
						},
					},
				})
			end,
			["ts_ls"] = function()
				lspconfig["ts_ls"].setup({
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
				})
			end,
			["angularls"] = function()
				lspconfig["angularls"].setup({
					capabilities = capabilities,
					root_dir = require("lspconfig/util").root_pattern(
						"package.json",
						"tsconfig.json",
						"jsconfig.json",
						".git"
					),
				})
			end,
		})
	end,
}
