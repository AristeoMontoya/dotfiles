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
