return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"lua_ls",
				"emmet_ls",
				"pyright",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
			},
		})
		-- 	local lspconfig = require("lspconfig")
		-- 	local capabilities = require("cmp_nvim_lsp").default_capabilities()
		--
		-- 	lspconfig["lua_ls"].setup({
		-- 		settings = {
		-- 			Lua = {
		-- 				runtime = {
		-- 					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
		-- 					version = "LuaJIT",
		-- 					-- Setup your lua path
		-- 					path = V.split(package.path, ";"),
		-- 				},
		-- 				diagnostics = {
		-- 					-- Get the language server to recognize the `vim` global
		-- 					globals = { "vim" },
		-- 				},
		-- 				workspace = {
		-- 					-- Make the server aware of Neovim runtime files
		-- 					library = {
		-- 						[V.fn.expand("$VIMRUNTIME/lua")] = true,
		-- 						[V.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
		-- 					},
		-- 				},
		-- 			},
		-- 		},
		-- 	})
		--
		-- 	lspconfig["pyright"].setup({
		-- 		capabilities = capabilities,
		-- 		settings = {
		-- 			pyright = {
		-- 				autoImportCompletion = true,
		-- 			},
		-- 			python = {
		-- 				analysis = {
		-- 					autoSearchPaths = true,
		-- 					diagnosticMode = "openFilesOnly",
		-- 					useLibraryCodeForTypes = true,
		-- 					typeCheckingMode = "off",
		-- 				},
		-- 			},
		-- 		},
		-- 	})
		--
		-- 	lspconfig["dockerls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["bashls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["cssls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["emmet_ls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["gradle_ls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["groovyls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["html"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["jsonls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["angularls"].setup({
		-- 		capabilities = capabilities,
		-- 		root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		-- 	})
		--
		-- 	lspconfig["tsserver"].setup({
		-- 		capabilities = capabilities,
		-- 		javascript = {
		-- 			referencesCodeLens = {
		-- 				enabled = true,
		-- 			},
		-- 		},
		-- 		typescript = {
		-- 			referencesCodeLens = {
		-- 				enabled = true,
		-- 			},
		-- 		},
		-- 		root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		-- 	})
		--
		-- 	lspconfig["vimls"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["lemminx"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
		-- 	lspconfig["ccls"].setup({
		-- 		capabilities = capabilities,
		-- 		cmd = { "ccls" },
		-- 		filetypes = { "cpp", "c" },
		-- 		root_dir = require("lspconfig/util").root_pattern("compile_commands.json", ".ccls", ".git"),
		-- 	})
	end,
}
