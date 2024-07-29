return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Load pre-defined servers
		local lsp_servers = require("defaults.lsp.servers")
		local linters = require("defaults.lsp.linters")
		local formatters = require("defaults.lsp.formatters")
		local debuggers = require("defaults.dap")
		local linters_debuggers_and_formatters = vim.tbl_deep_extend("keep", linters, formatters, debuggers)

		-- enable mason and configure icons
		-- Mason complains if the setup method isn't called
		-- before calling lsp_config.
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
			ensure_installed = lsp_servers,
		})

		mason_tool_installer.setup({
			ensure_installed = linters_debuggers_and_formatters,
		})
	end,
}
