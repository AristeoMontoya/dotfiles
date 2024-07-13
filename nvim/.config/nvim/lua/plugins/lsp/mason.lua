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
		--
		-- 	lspconfig["lemminx"].setup({
		-- 		capabilities = capabilities,
		-- 	})
		--
	end,
}
