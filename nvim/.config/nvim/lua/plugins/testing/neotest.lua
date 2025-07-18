local versions = require("settings.versions")
return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		{
			"fredrikaverpil/neotest-golang",
			commit = versions.neotest_golang,
			dependencies = {
				"leoluz/nvim-dap-go",
				commit = versions.neotest_dap_go,
			},
		},
	},
	keys = {
		{ "<leader>tr", "<cmd>Neotest run<CR>", desc = "Run nearest test" },
		{ "<leader>ts", "<cmd>lua require('neotest').run.stop()<CR>", desc = "Stop nearest test" },
		{ "<leader>tS", "<cmd>Neotest summary<CR>", desc = "Show test summary" },
		{ "<leader>tt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run test file" },
		{ "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = "Debug nearest test" },
		{ "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Open test output" },
		{ "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle historical output panel" },
	},
	commit = versions.neotest,
	opts = function()
		local neotest_golang = require("neotest-golang")
		require("dap-go").setup()

		return {
			adapters = {
				neotest_golang({
					dap = { justMyCode = false },
				}),
			},
		}
	end,
}
