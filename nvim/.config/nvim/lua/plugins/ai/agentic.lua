return {
	"carlos-algms/agentic.nvim",
	commit = require("settings.versions").agentic,
	enabled = require("utils.config_manager").is_feature_enabled("ai"),
	--- @type agentic.PartialUserConfig
	opts = {
		-- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp"
		provider = "cursor-acp", -- setting the name here is all you need to get started
	},

	-- these are just suggested keymaps; customize as desired
	keys = {
		{
			"<leader>it",
			function()
				require("agentic").toggle()
			end,
			mode = { "n", "v" },
			desc = "Toggle Agentic Chat",
		},
		{
			"<leader>ic",
			function()
				require("agentic").add_selection_or_file_to_context()
			end,
			mode = { "n", "v" },
			desc = "Add file or selection to Agentic to Context",
		},
		{
			"<leader>in",
			function()
				require("agentic").new_session()
			end,
			mode = { "n", "v" },
			desc = "New Agentic Session",
		},
		{
			"<leader>ir", -- ai Restore
			function()
				require("agentic").restore_session()
			end,
			desc = "Agentic Restore session",
			silent = true,
			mode = { "n", "v" },
		},
		{
			"<leader>id", -- ai Diagnostics
			function()
				require("agentic").add_current_line_diagnostics()
			end,
			desc = "Add current line diagnostic to Agentic",
			mode = { "n" },
		},
		{
			"<leader>iD", -- ai all Diagnostics
			function()
				require("agentic").add_buffer_diagnostics()
			end,
			desc = "Add all buffer diagnostics to Agentic",
			mode = { "n" },
		},
	},
}
