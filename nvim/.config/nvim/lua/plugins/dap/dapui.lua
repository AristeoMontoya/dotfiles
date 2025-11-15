local versions = require("settings.versions")
return {
	"rcarriga/nvim-dap-ui",
	commit = versions.nvim_dap_ui,
	dependencies = {
		{ "mfussenegger/nvim-dap", commit = versions.nvim_dap },
		{ "nvim-neotest/nvim-nio", commit = versions.nvim_nio },
		{ "theHamsta/nvim-dap-virtual-text", commit = versions.nvim_dap_virtual_text },
	},
	opts = function()
		require("nvim-dap-virtual-text").setup()

		local keymap = vim.keymap
		local opts = { silent = true }

		opts.desc = "Toggle breakpoint"
		keymap.set("n", "db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)

		opts.desc = "Set conditional breakpoint"
		keymap.set("n", "de", function()
			vim.ui.input({ prompt = "Breakpoint condition: ", completion = "nvim_lsp" }, function(input)
				if input then
					require("dap").set_breakpoint(input)
				else
					vim.api.nvim_notify("No input provided", vim.log.levels.WARN, {})
				end
			end)
		end, opts)

		opts.desc = "Set logpoint"
		keymap.set(
			"n",
			"dp",
			"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
			opts
		)

		opts.desc = "Step continue"
		keymap.set("n", "<leader>dc", function()
			-- if vim.fn.filereadable(".vscode/launch.json") then
			-- 	require("dap.ext.vscode").load_launchjs(nil, nil)
			-- end
			require("dap").continue()
		end, opts)

		opts.desc = "Step into"
		keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)

		opts.desc = "Step over"
		keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)

		opts.desc = "Step out"
		keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)

		opts.desc = "Run to cursor"
		keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.run_to_cursor()<cr>", opts)

		opts.desc = "Jump cursor to execution point"
		keymap.set("n", "<leader>dR", "<cmd>lua require'dap'.focus_frame()<cr>", opts)

		opts.desc = "Run last"
		keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)

		opts.desc = "Toggle DAP Ui"
		keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)

		opts.desc = "DAP exit"
		keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", opts)

		opts.desc = "Evaluate expression under cursor"
		keymap.set("n", "<leader>dE", "<cmd>lua require'dapui'.eval()<cr>", opts)

		local hl_status, set_highlights = pcall(require, "utils.register_highlights") --- @type boolean, utils.RegisterHighlights
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "DapUIStopNC", value = { bg = nil } },
			{ group = "DapUINormalNC", value = { bg = nil } },
			{ group = "DapUIFloatNormal", value = { bg = nil } },
			{ group = "DapUIUnavailableNC", value = { fg = "#424242", bg = nil } },
			{ group = "DapUIUnavailable", value = { fg = "#424242", bg = nil } },
			{ group = "DapUIPlayPauseNC", value = { fg = "#a9ff68", bg = "#454C59" } },
			{ group = "DapUIPlayPause", value = { fg = "#a9ff68", bg = "#454C59" } },
			{ group = "DapUIRestartNC", value = { fg = "#a9ff68", bg = "#454C59" } },
			{ group = "DapUIRestart", value = { fg = "#a9ff68", bg = "#454C59" } },
			{ group = "DapUIStopNC", value = { fg = "#f70067", bg = "#454C59" } },
			{ group = "DapUIStop", value = { fg = "#f70067", bg = "#454C59" } },
			{ group = "DapUIStepOverNC", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapUIStepOver", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapUIStepIntoNC", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapUIStepInto", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapUIStepBackNC", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapUIStepBack", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapUIStepOutNC", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapUIStepOut", value = { fg = "#00f1f5", bg = "#454C59" } },
			{ group = "DapStoppedLine", value = { bg = "#424242" } },
		})

		return {
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 10,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		}
	end,
}
