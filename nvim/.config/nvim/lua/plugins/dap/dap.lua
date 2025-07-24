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

		dap.defaults.fallback.switchbuf = "usevisible,usetab,uselast"
		dap.defaults.fallback.exception_breakpoints = { "uncaught" }

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		-- Close ui only if its not an error
		dap.listeners.after.event_exited.dap_ui_config = function(_, body)
			if body and body.exitCode then
				if body.exitCode == 0 then
					dapui.close()
				end
			end
		end

		dap.listeners.after.disconnect.dap_ui_config = function()
			dapui.close()
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dap-repl",
			callback = function()
				require("dap.ext.autocompl").attach()
			end,
		})
	end,
}
