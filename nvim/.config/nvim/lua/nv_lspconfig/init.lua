local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["sumneko_lua"].setup ({
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
})

lspconfig["pyright"].setup({
	capabilities = capabilities
})

lspconfig["dockerls"].setup({
	capabilities = capabilities
})

lspconfig["bashls"].setup({
	capabilities = capabilities
})

lspconfig["cssls"].setup({
	capabilities = capabilities
})

lspconfig["emmet_ls"].setup({
	capabilities = capabilities
})

lspconfig["gradle_ls"].setup({
	capabilities = capabilities
})

lspconfig["groovyls"].setup({
	capabilities = capabilities
})

lspconfig["html"].setup({
	capabilities = capabilities
})

lspconfig["jsonls"].setup({
	capabilities = capabilities
})

lspconfig["tsserver"].setup({
	capabilities = capabilities,
	root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", "."),
})

lspconfig["vimls"].setup({
	capabilities = capabilities
})

lspconfig["lemminx"].setup({
	capabilities = capabilities
})

lspconfig["ccls"].setup({
	capabilities = capabilities,
	cmd = { "ccls" },
	filetypes = { "cpp", "c" },
	root_dir = require("lspconfig/util").root_pattern("compile_commands.json", ".ccls", ".git"),
})
