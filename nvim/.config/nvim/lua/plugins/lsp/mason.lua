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
		})

		mason_tool_installer.setup({
			ensure_installed = ensure_installed_tools,
		})
	end,
}
