require'lspconfig'.gopls.setup{
	cmd = {DATA_PATH .. "/lspinstall/go/gopls"},
	settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
	root_dir = vim.loop.cwd,
	init_options = {usePlaceholders = true, completeUnimported = true},
	on_attach = require'lsp'.common_on_attach
}
