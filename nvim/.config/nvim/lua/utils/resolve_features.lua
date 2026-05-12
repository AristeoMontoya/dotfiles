--- Returns the resolved feature list between user and default features
--- @return config.Features
local function resolve_features()
	local default_features = require("defaults.features")
	local user_ok, overrides = pcall(require, "user.overrides.features") ---@type boolean, config.Features

	if not user_ok then
		overrides = {} --- @type config.Features
	end

	local merged_features = vim.tbl_deep_extend("force", default_features, overrides)
	return merged_features
end

return resolve_features
