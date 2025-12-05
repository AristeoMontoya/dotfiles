local versions = require("settings.versions")
return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	commit = versions.avante,
	---@module 'avante'
	---@type avante.Config
	opts = {
		provider = "copilot",
	},
	dependencies = {
		{ "nvim-lua/plenary.nvim", commit = versions.plenary },
		{ "MunifTanjim/nui.nvim", commit = versions.nui },
		{ "hrsh7th/nvim-cmp", commit = versions.nvim_cmp }, -- autocompletion for avante commands and mentions
		{ "folke/snacks.nvim", commit = versions.snacks }, -- for input provider snacks
		{ "zbirenbaum/copilot.lua", commit = versions.copilot },
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			commit = versions.render_markdown,
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
