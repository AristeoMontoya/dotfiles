return {
	"L3MON4D3/LuaSnip",
	commit = "0f7bbce",
	-- event = "InsertEnter",
	config = function()
		local ls = require("luasnip")
		local types = require("luasnip.util.types")

		ls.config.setup({
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "●", "DiffAdd" } },
					},
				},
				[types.insertNode] = {
					active = {
						virt_text = { { "●", "DiffDelete" } },
					},
				},
			},
		})

		require("luasnip.loaders.from_lua").load({ paths = CONFIG_PATH .. "/snippets" })
	end,
}
