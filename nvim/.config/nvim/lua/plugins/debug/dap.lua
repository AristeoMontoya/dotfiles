local versions = require("settings.versions")
return {
	"mfussenegger/nvim-dap",
	commit = versions.nvim_dap,
	dependencies = {
		{ "rcarriga/nvim-dap-ui", commit = versions.nvim_dap_ui },
		{ "jay-babu/mason-nvim-dap.nvim", commit = versions.mason_nvim_dap },
		{ "nvim-neotest/nvim-nio", commit = versions.nvim_nio },
		{ "williamboman/mason.nvim", commit = versions.mason },
	},
	config = function()
		require("mason").setup()
		require("mason-nvim-dap").setup()
		require("dap-go").setup()

		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		set_highlights({
			{ group = "DapStoppedLine", value = { bg = "#424242" } },
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

		local dap = require("dap")
		dap.defaults.fallback.switchbuf = "usevisible,usetab,uselast"
		dap.defaults.fallback.exception_breakpoints = { "uncaught" }

		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug",
				request = "launch",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug test", -- configuration for debugging test files
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			-- works with go.mod packages and sub packages
			{
				type = "delve",
				name = "Debug test (go.mod)",
				request = "launch",
				mode = "test",
				program = "./${relativeFileDirname}",
			},
		}
	end,
	-- stylua: ignore
	keys = {
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, "Toggle breakpoint", },
		{
			"<leader>de",
			function()
				vim.ui.input({ prompt = "Breakpoint condition: ", completion = "nvim_lsp" }, function(input)
					if input then
						require("dap").set_breakpoint(input)
					else
						vim.api.nvim_notify("No input provided", vim.log.levels.WARN, {})
					end
				end)
			end,
			"Set conditional breakpoint",
		},
		{ "<leader>dp", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Set logpoint", },
		{ "<leader>dc", function() require("dap").continue() end, "Step continue", },
		{ "<leader>di", function() require("dap").step_into() end, "Step into", },
		{ "<leader>do", function() require("dap").step_over() end, "Step over", },
		{ "<leader>dO", function() require("dap").step_out() end, "Step out", },
		{ "<leader>dr", function() require("dap").run_to_cursor() end, "Run to cursor", },
		{ "<leader>dR", function() require("dap").focus_frame() end, "Jump cursor to execution point", },
		{ "<leader>dl", function() require("dap").run_last() end, "Run last", },
		{ "<leader>dx", function() require("dap").terminate() end, "DAP exit", },
		{ "<leader>du", function() require("dapui").toggle() end, "Toggle DAP Ui", },
		{ "<leader>dE", function() require("dapui").eval() end, "Evaluate expression under cursor", },
	},
}
