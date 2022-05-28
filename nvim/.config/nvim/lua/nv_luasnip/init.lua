local ls = require('luasnip')
local types = require('luasnip.util.types')

ls.config.setup({
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { '●', 'DiffAdd' } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { '●', 'DiffDelete' } },
            },
        },
    },
})

require("luasnip.loaders.from_lua").load({paths = CONFIG_PATH .. "/snippets"})
