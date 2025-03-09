local versions = require("settings.versions")
return {
	"mfussenegger/nvim-dap",
	commit = versions.nvim_dap,
	dependencies = {
		{ "igorlfs/nvim-dap-view", commit = versions.nvim_dap_view },
		{ "rcarriga/cmp-dap", commit = versions.cmp_dap },
		{ "nvim-neotest/nvim-nio", commit = versions.nvim_nio },
		{ "theHamsta/nvim-dap-virtual-text", commit = versions.nvim_dap_virtual_text },
		{ "jay-babu/mason-nvim-dap.nvim", commit = versions.mason_nvim_dap },
		{ "leoluz/nvim-dap-go", commit = versions.neotest_dap_go },
	},
	config = function()
		local dap_go_status_ok, dap_go = pcall(require, "dap-go")
		if not dap_go_status_ok then
			return
		end
		dap_go.setup()

		local virtual_text_status_ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
		if not virtual_text_status_ok then
			return
		end
		virtual_text.setup()

		local dap_status_ok, dap = pcall(require, "dap")
		if not dap_status_ok then
			return
		end

		local dap_view_status_ok, dap_view = pcall(require, "dap-view")
		if not dap_view_status_ok then
			return
		end

		dap_view.setup({
			winbar = {
				show = true,
				sections = { "watches", "exceptions", "breakpoints", "threads", "repl" },
				-- Must be one of the sections declared above
				default_section = "watches",
			},
			windows = {
				height = 12,
				terminal = {
					-- 'left'|'right'|'above'|'below': Terminal position in layout
					position = "left",
					-- List of debug adapters for which the terminal should be ALWAYS hidden
					hide = {
						"go"
					},
					-- Hide the terminal when starting a new session
					start_hidden = false,
				},
			},
		})

		local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
		if not mason_dap_status then
			return
		end

		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		mason_dap.setup({
			handlers = {
				function(config)
					-- all sources with no handler get passed here
					-- Keep original functionality
					require("mason-nvim-dap").default_setup(config)
				end,
			},
			automatic_setup = true,
		})

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" }
		)

		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapStopped",
			{ text = "→", texthl = "DiagnosticVirtualTextHint", linehl = "DapStoppedLine", numhl = "" }
		)

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

		-- opts.desc = "Toggle DAP Ui"
		-- keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
		--
		opts.desc = "DAP exit"
		keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", opts)

		opts.desc = "Evaluate expression under cursor"
		keymap.set("n", "<leader>dE", "<cmd>lua require'dapui'.eval()<cr>", opts)

		dap.listeners.before.attach["dap-view-config"] = function()
			dap_view.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dap_view.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dap_view.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dap_view.close()
		end
	end,
}
