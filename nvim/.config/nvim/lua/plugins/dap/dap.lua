local versions = require("settings.versions")
return {
	"rcarriga/cmp-dap",
	commit = versions.cmp_dap,
	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			commit = versions.mason_nvim_dap,
		},
	},
	-- event = "InsertEnter",
	config = function()
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
				function(source_name)
					-- all sources with no handler get passed here
					-- Keep original functionality of `automatic_setup = true`
					require("mason-nvim-dap.automatic_setup")(source_name)
				end,
			},
			ensure_installed = {
				"python",
				"bash",
			},
			automatic_setup = true,
		})

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

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
