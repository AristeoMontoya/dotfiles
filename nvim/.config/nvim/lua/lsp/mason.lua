local overrides_ok, overrides = pcall(require, "lsp.overrides")
local filter_ok, filter = pcall(require, "utils.filter_tables")

local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

mason.setup()

local defaults = require("lsp.default_servers")

local ensure_installed = {}

if overrides_ok and filter_ok then
	ensure_installed = filter(defaults, overrides.ignored)
else
	ensure_installed = defaults
end

mason_lspconfig.setup({
	ensure_installed = ensure_installed
})
