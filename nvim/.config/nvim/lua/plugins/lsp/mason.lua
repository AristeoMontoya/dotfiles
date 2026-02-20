local versions = require("settings.versions")
return {
	"williamboman/mason-lspconfig.nvim",
	commit = versions.mason_lspconfig,
	dependencies = {
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", commit = versions.mason_tool_installer },
		{ "neovim/nvim-lspconfig", commit = versions.nvim_lspconfig, event = { "BufReadPre", "BufNewFile" } },
		{
			"williamboman/mason.nvim",
			commit = versions.mason,
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
	},
	opts = function()
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Load pre-defined servers, linters, formatters and debuggers
		local default_servers = require("defaults.lsp.servers") --- @type config.LspServers
		local linters = require("defaults.lsp.linters") --- @type config.Linters
		local formatters = require("defaults.lsp.formatters") --- @type config.Formatters
		local debuggers = require("defaults.dap") --- @type config.DapList

		-- Load user defined overrides
		-- Some devices are not compatible with my defaults.
		local lsp_overrides_ok, lsp_overrides = pcall(require, "user.overrides.lsp.servers") --- @type boolean, config.LspServers
		local linters_overrides_ok, linters_overrides = pcall(require, "user.overrides.linters") --- @type boolean, config.Linters
		local formatters_overrides_ok, formatters_overrides = pcall(require, "user.overrides.formatters") --- @type boolean, config.Formatters
		local debuggers_overrides_ok, debuggers_overrides = pcall(require, "user.overrides.dap") --- @type boolean, config.DapList
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

		for _, tool in pairs({ linters, formatters, debuggers }) do
			vim.list_extend(ensure_installed_tools, tool)
		end

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = ensure_lsp_installed,
		})

		mason_tool_installer.setup({
			ensure_installed = ensure_installed_tools,
		})
	end,
}
