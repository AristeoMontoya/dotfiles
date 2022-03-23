local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
	if server.name == "jdtls" then
		return
	end
    server:setup(opts)
end)
