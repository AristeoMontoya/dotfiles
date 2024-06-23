local builtin = require("statuscol.builtin")
require("statuscol").setup({
	-- configuration goes here, for example:
	-- relculright = true,
	segments = {
		{
			sign = { name = { ".*" } },
			click = "v:lua.ScSa",
		},
		{
			text = { builtin.lnumfunc },
			condition = { true, builtin.not_empty },
			click = "v:lua.ScLa",
		},
		{
			sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true },
			click = "v:lua.ScSa",
		},
		{
			text = { builtin.foldfunc },
			click = "v:lua.ScFa",
		},
	},
})
