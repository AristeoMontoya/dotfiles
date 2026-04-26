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
		local config_manager = require("utils.config_manager")

		-- Load pre-defined servers, linters, formatters and debuggers
		local ensure_lsp_installed = config_manager.get_lsp_servers()
		local lsp_configs = config_manager.get_lsp_configurations()
		local linters = config_manager.get_linters()
		local formatters = config_manager.get_formatters()
		local debuggers = config_manager.get_debuggers()

		local ensure_installed_tools = {}
		for _, tool in pairs({ linters, formatters, debuggers }) do
			vim.list_extend(ensure_installed_tools, tool)
		end

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = ensure_lsp_installed,
			automatic_enable = true,
		})

		mason_tool_installer.setup({
			ensure_installed = ensure_installed_tools,
		})

		-- Setting overrides
		for _, server in ipairs(ensure_lsp_installed) do
			local server_opts = lsp_configs[server] or {}

			if next(server_opts) ~= nil then
				vim.lsp.config(server, server_opts)
			end
		end
	end,
}
