local versions = require("settings.versions")
return {
	"rcarriga/cmp-dap",
	commit = versions.cmp_dap,
	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			commit = versions.mason_nvim_dap,
		},
		{
			"leoluz/nvim-dap-go",
			commit = versions.neotest_dap_go,
		},
	},
	-- event = "InsertEnter",
	config = function()
		require("dap-go").setup()
		local dap_status_ok, dap = pcall(require, "dap")
		if not dap_status_ok then
			return
		end

		local dap_ui_status_ok, dapui = pcall(require, "dapui")
		if not dap_ui_status_ok then
			return
		end

		local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
		if not mason_dap_status then
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
		vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })


		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapStopped",
			{ text = "→", texthl = "DiagnosticVirtualTextHint", linehl = "DapStoppedLine", numhl = "" }
		)

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
