local versions = require("settings.versions")
local config_manager = require("utils.config_manager")

return {
	"olimorris/codecompanion.nvim",
	commit = versions.codecompanion,
	enabled = config_manager.is_feature_enabled("ai"),
	dependencies = {
		{ "nvim-lua/plenary.nvim", commit = versions.plenary },
		{ "nvim-treesitter/nvim-treesitter", commit = versions.nvim_treesitter },
		{
			"MeanderingProgrammer/render-markdown.nvim",
			commit = versions.render_markdown,
			ft = { "markdown", "codecompanion" },
		},
	},
	opts = {
		interactions = {
			chat = {
				adapter = "cursor_cli",

				tools = {
					["insert_edit_into_file"] = {
						opts = {
							require_approval_before = true,
						},
					},
					["run_command"] = {
						opts = {
							require_approval_before = true,
						},
					},
				},

				-- Clearer role headers so you always know who's speaking
				roles = {
					llm = function(adapter)
						return adapter.formatted_name
					end,
					user = "Me",
				},
			},
		},

		display = {

			action_palette = {
				-- width = 95,
				-- height = 10,
				prompt = "Prompt ", -- Prompt used for interactive LLM calls
				provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
				opts = {
					show_preset_actions = true, -- Show the preset actions in the action palette?
					show_preset_prompts = true, -- Show the preset prompts in the action palette?
					title = "CodeCompanion actions", -- The title of the action palette
				},
			},

			diff = {
				enabled = true,

				threshold_for_chat = 2,

				word_highlights = {
					additions = true,
					deletions = true,
				},
			},
			chat = {
				-- Cleaner separator between messages
				separator = "─",

				-- This is the key one: disables codecompanion's own markdown decorations
				-- so your external markdown renderer (e.g. render-markdown.nvim) takes over cleanly
				show_header_separator = false,

				-- Visual feedback that your message was sent
				show_tools_processing = true,

				-- Token count per response gives a subtle "response received" cue
				show_token_count = true,

				-- Fold context blocks so they don't clutter the view
				fold_context = true,
				start_in_insert_mode = true,
				auto_scroll = true,
				window = {
					layout = "vertical",
					position = "right",
					width = 0.3,
					opts = {
						number = false,
						relativenumber = false,
					},
				},
			},
		},
	},

	keys = {
		-- Toggle chat (replaces agentic.toggle)
		{
			"<leader>it",
			function()
				require("codecompanion").toggle()
			end,
			mode = { "n", "v" },
			desc = "Toggle CodeCompanion Chat",
		},
		-- Add file/selection to context (replaces add_selection_or_file_to_context)
		-- In codecompanion this is done via the /buffer slash command or #buffer context,
		-- but the closest direct API equivalent is opening the chat with the visual selection
		-- FIXME: Broken, closes the chat.
		{
			"<leader>ic",
			function()
				local mode = vim.fn.mode()
				local ctx = (mode == "v" or mode == "V") and "#{selection}" or "#{buffer}"
				-- Exit visual mode before toggling, otherwise it selects text in the chat buffer
				if mode == "v" or mode == "V" then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
				end
				require("codecompanion").toggle()
				vim.schedule(function()
					local buf = vim.api.nvim_get_current_buf()
					local line_count = vim.api.nvim_buf_line_count(buf)
					local last_line = vim.api.nvim_buf_get_lines(buf, line_count - 1, line_count, false)[1] or ""
					if last_line == "" then
						vim.api.nvim_buf_set_lines(buf, line_count - 1, line_count, false, { ctx .. " " })
					else
						vim.api.nvim_buf_set_lines(
							buf,
							line_count - 1,
							line_count,
							false,
							{ last_line .. " " .. ctx .. " " }
						)
					end
					vim.api.nvim_win_set_cursor(0, { line_count, #last_line + #ctx + 2 })
				end)
			end,
			mode = { "n", "v" },
			desc = "Add file or selection context to chat",
		},
		-- New session (replaces agentic.new_session)
		{
			"<leader>in",
			function()
				require("codecompanion").chat()
			end,
			mode = { "n", "v" },
			desc = "New CodeCompanion Chat",
		},
		-- Add current line diagnostics (replaces add_current_line_diagnostics)
		{
			"<leader>id",
			function()
				require("codecompanion").chat({ context = "diagnostics" })
			end,
			mode = { "n" },
			desc = "Add current line diagnostics to CodeCompanion",
		},
		-- Add all buffer diagnostics (replaces add_buffer_diagnostics)
		{
			"<leader>iD",
			function()
				require("codecompanion").chat({ context = "diagnostics" })
			end,
			mode = { "n" },
			desc = "Add all buffer diagnostics to CodeCompanion",
		},
		-- Restore/resume session (replaces agentic.restore_session)
		{
			"<leader>ir",
			function()
				-- Open a new chat buffer, then trigger the /resume slash command
				local chat = require("codecompanion").chat()
				if chat then
					vim.schedule(function()
						chat:slash_command("resume")
					end)
				end
			end,
			desc = "Resume a previous CodeCompanion session",
			silent = true,
			mode = { "n", "v" },
		},
	},
}
