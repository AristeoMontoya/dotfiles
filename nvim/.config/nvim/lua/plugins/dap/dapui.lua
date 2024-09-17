return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	opts = function()
		require("nvim-dap-virtual-text").setup()

		local keymap = vim.keymap
		local opts = { silent = true }

		opts.desc = "Toggle breakpoint"
		keymap.set("n", "Db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)

		opts.desc = "Set conditional breakpoint"
		keymap.set("n", "De", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)

		opts.desc = "Set logpoint"
		keymap.set(
			"n",
			"Dp",
			"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
			opts
		)

		opts.desc = "Step continue"
		keymap.set("n", "<leader>Dc", "<cmd>lua require'dap'.continue()<cr>", opts)

		opts.desc = "Step into"
		keymap.set("n", "<leader>Di", "<cmd>lua require'dap'.step_into()<cr>", opts)

		opts.desc = "Step over"
		keymap.set("n", "<leader>Do", "<cmd>lua require'dap'.step_over()<cr>", opts)

		opts.desc = "Step out"
		keymap.set("n", "<leader>DO", "<cmd>lua require'dap'.step_out()<cr>", opts)

		opts.desc = "Toggle repl"
		keymap.set("n", "<leader>Dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)

		opts.desc = "Run last"
		keymap.set("n", "<leader>Dl", "<cmd>lua require'dap'.run_last()<cr>", opts)

		opts.desc = "Toggle DAP UI"
		keymap.set("n", "<leader>Du", "<cmd>lua require'dapui'.toggle()<cr>", opts)

		opts.desc = "DAP exit"
		keymap.set("n", "<leader>Dx", "<cmd>lua require'dap'.terminate()<cr>", opts)

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
