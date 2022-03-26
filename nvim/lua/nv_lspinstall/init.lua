local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}
	if server.name == "jdtls" then
		return
	end

	if server.name == "arduino_language_server" then
		opts.on_new_config = function (config, root_dir)
			local partial_cmd = server:get_default_options().cmd
			local MY_FQBN = "arduino:avr:nano"
			config.cmd = V.list_extend(partial_cmd, { "-fqbn", MY_FQBN })
		end
	end
    server:setup(opts)
end)
