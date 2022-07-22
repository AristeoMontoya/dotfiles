require('globals')
-- TODO figure out why this don't work
V.fn.sign_define(
	"DiagnosticSignError",
	{texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError"}
)
V.fn.sign_define(
	"DiagnosticSignWarn",
	{texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticSignWarning"}
)
V.fn.sign_define(
	"DiagnosticSignHint",
	{texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint"}
)
V.fn.sign_define(
	"DiagnosticSignInformation",
	{texthl = "DiagnosticSignInformation", text = "", numhl = "DiagnosticSignInformation"}
)

V.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
V.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
V.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
V.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
V.cmd("nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>")
V.cmd("nnoremap <silent> <leader>la <cmd>lua vim.lsp.buf.code_action()<CR>")
V.cmd("nnoremap <silent> <leader>lr <cmd>lua vim.lsp.buf.rename()<CR>")
V.cmd("nnoremap <silent> <A-n> <cmd>lua vim.lsp.diagnostic_jump_next()<CR>")
V.cmd("nnoremap <silent> <A-p> <cmd>lua vim.lsp.diagnostic_jump_prev()<CR>")
V.cmd("nnoremap <silent> <C-space> <cmd>lua vim.lsp.buf.completion()<CR>")
V.cmd("nnoremap <silent> <leader>ll <cmd>lua vim.diagnostic.open_float()<CR>")
V.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

V.lsp.handlers['textDocument/publishDiagnostics'] =
V.lsp.with(V.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		prefix = "",
		spacing = 5,
		severity_limit = 'Warning'
	},
	signs = true,
	update_in_insert = true
})

local function documentHighlight(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		V.api.nvim_exec(
		[[
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]],
		false
		)
	end
end
local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
	documentHighlight(client, bufnr)
end

function lsp_config.tsserver_on_attach(client, bufnr)
	lsp_config.common_on_attach(client, bufnr)
	client.resolved_capabilities.document_formatting = false
end

return lsp_config
