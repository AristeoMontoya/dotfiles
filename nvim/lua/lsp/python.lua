-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(V.lsp.protocol.make_client_capabilities())

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').pyright.setup {
-- 	capabilities = capabilities
}
