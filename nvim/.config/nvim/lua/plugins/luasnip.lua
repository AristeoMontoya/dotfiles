return {
	"L3MON4D3/LuaSnip",
	commit = require("settings.versions").LuaSnip,
	-- event = "InsertEnter",
	config = function()
		local ls = require("luasnip")
		local types = require("luasnip.util.types")
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		opts.desc = "Go to next Luasnip node"
		map("i", "<C-n>", "<Plug>luasnip-next-choice", opts)

		opts.desc = "Go to next Luasnip node"
		map("s", "<C-n>", "<Plug>luasnip-next-choice", opts)

		opts.desc = "Go to last Luasnip node"
		map("i", "<C-p>", "<Plug>luasnip-prev-choice", opts)

		opts.desc = "Go to last Luasnip node"
		map("s", "<C-p>", "<Plug>luasnip-prev-choice", opts)

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

		require("luasnip.loaders.from_lua").lazy_load({ paths = CONFIG_PATH .. "/snippets" })
	end,
}
