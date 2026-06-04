local versions = require("settings.versions")
local cmp_config = {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	commit = versions.cmp_nvim_lsp,
	enabled = false,
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})
	end,
}

local blink_config = {
	"saghen/blink.cmp",
	commit = versions.blink,
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", commit = versions.nvim_lsp_file_operations, config = true },
		{ "folke/lazydev.nvim", commit = versions.lazydev, opts = {} },
	},
	config = function()
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})
	end,
}

return cmp_config
