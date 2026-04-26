--- @alias config.LspConfigs table<string, vim.lsp.Config>

--- Intended to be coppied without "template" prefix.
--- The file wont be traccked by git.
--- Values added here will be merged with those in lsp/configs.lua
--- and take presedence over them.
--- The example python config here is redundant.
--- @type config.LspConfigs
return {
	pyright = {
		settings = {
			pyright = {
				autoImportCompletion = true,
			},
		},
	},
}
