return {
	"williamboman/mason.nvim",
	commit = "e2f7f90",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim", commit = "43894ad" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", commit = "c5e07b8" },
	},
	opts = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Load pre-defined servers, linters, formatters and debuggers
		local default_servers = require("defaults.lsp.servers")
		local linters = require("defaults.lsp.linters")
		local formatters = require("defaults.lsp.formatters")
		local debuggers = require("defaults.dap")

		-- Load user defined overrides
		-- Some devices are not compatible with my defaults.
		local lsp_overrides_ok, lsp_overrides = pcall(require, "user.overrides.lsp")
		local linters_overrides_ok, linters_overrides = pcall(require, "user.overrides.linters")
		local formatters_overrides_ok, formatters_overrides = pcall(require, "user.overrides.formatters")
		local debuggers_overrides_ok, debuggers_overrides = pcall(require, "user.overrides.dap")
		local filter_ok, filter = pcall(require, "utils.filter_tables")

		local ensure_lsp_installed = {}
		local ensure_installed_tools = {}

		if filter_ok then
			if lsp_overrides_ok then
				ensure_lsp_installed = filter(default_servers, lsp_overrides)
			else
				ensure_lsp_installed = default_servers
			end

			if linters_overrides_ok then
				linters = filter(linters, linters_overrides)
			end

			if formatters_overrides_ok then
				formatters = filter(formatters, formatters_overrides)
			end

			if debuggers_overrides_ok then
				debuggers = filter(debuggers, debuggers_overrides)
			end
		end

		for _, tool in pairs({linters, formatters, debuggers}) do
			vim.list_extend(ensure_installed_tools, tool)
		end

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
			ensure_installed = ensure_lsp_installed,
		})

		mason_tool_installer.setup({
			ensure_installed = ensure_installed_tools,
		})
	end,
}
