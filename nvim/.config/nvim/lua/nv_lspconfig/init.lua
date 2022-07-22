local lspconfig = require("lspconfig")

lspconfig.sumneko_lua.setup {
	settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = V.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[V.fn.expand('$VIMRUNTIME/lua')] = true, [V.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}
