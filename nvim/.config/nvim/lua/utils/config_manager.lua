local M = {}

local filter_tables = require("utils.filter_tables")

---@class ParserCache
---@field defaults? config.TSParsers
---@field overrides? config.TSParsers
---@field resolved? config.TSParsers

---@class LspCache
---@field defaults? config.LspServers
---@field overrides? config.LspServers
---@field resolved? config.LspServers

---@class LinterCache
---@field defaults? config.Linters
---@field overrides? config.Linters
---@field resolved? config.Linters

---@class FormatterCache
---@field defaults? config.Formatters
---@field overrides? config.Formatters
---@field resolved? config.Formatters

---@class DapCache
---@field defaults? config.DapList
---@field overrides? config.DapList
---@field resolved? config.DapList

---@class ConfigCache
---@field parsers? ParserCache
---@field lsp_servers? LspCache
---@field linters? LinterCache
---@field formatters? FormatterCache
---@field dap? DapCache
--- Session cache for resolved configurations. Changes made within that session will not take effect.
local cache = {}

local function safe_require(mod)
	local ok, result = pcall(require, mod)
	if ok then
		return result
	end
	return nil
end

local function resolve(config_name, defaults, overrides)
	if cache[config_name] then
		return cache[config_name]
	end

	local default = require(defaults)
	local user = safe_require(overrides) or {}

	-- User overrides wins
	local resolved = filter_tables(default, user)

	cache[config_name] = resolved
	return resolved
end

--- @return config.TSParsers
function M.get_ts_parsers()
	return resolve("parsers", "defaults.treesitter.default_parsers", "user.overrides.treesitter")
end

--- @return config.LspServers
function M.get_lsp_servers()
	return resolve("lsp_servers", "defaults.lsp.servers", "user.overrides.lsp.servers")
end

--- @return config.Linters
function M.get_linters()
	return resolve("linters", "defaults.lsp.linters", "user.overrides.linters")
end

--- @return config.Formatters
function M.get_formatters()
	return resolve("formatters", "defaults.lsp.formatters", "user.overrides.formatters")
end

--- @return config.DapList
function M.get_debuggers()
	return resolve("dap", "defaults.dap", "user.overrides.dap")
end

return M
