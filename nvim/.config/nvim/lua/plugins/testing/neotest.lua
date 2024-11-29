local versions = require("settings.versions")
return {
	"nvim-neotest/neotest",
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
		{ "<leader>ts", "<cmd>Neotest summary<CR>", desc = "Show test summary" },
		{ "<leader>tt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run test file" },
		{ "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = "Debug nearest test" },
	},
	commit = versions.neotest,
	opts = function()
		local neotest_golang = require("neotest-golang")

		return {
			adapters = {
				-- require("neotest-python")({
				-- 	dap = { justMyCode = false },
				-- }),
				neotest_golang({
					dap = { justMyCode = false },
				}),
				-- require("neotest-plenary"),
				-- require("neotest-vim-test")({
				-- 	ignore_file_types = { "python", "vim", "lua" },
				-- }),
			},
		}
	end,
}
