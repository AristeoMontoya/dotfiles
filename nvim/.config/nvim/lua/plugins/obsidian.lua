return {
	"obsidian-nvim/obsidian.nvim",
	commit = require("settings.versions").obsidian,
	enabled = require("utils.config_manager").is_feature_enabled("notes"),
	opts = function()
		local config_manager = require("utils.config_manager")

		---@module 'obsidian'
		---@type obsidian.config
		local opts = {
			picker = { name = "snacks.picker" },
			legacy_commands = false,
			workspaces = {
			-- Empty. Intended to be defined in local overrides
			},
		}

		local obsidian_overrides = config_manager.get_local_plugin_config("obsidian")

		-- Merging tables, user overrides win
		return vim.tbl_deep_extend("force", opts, obsidian_overrides)
	end,
}
