return {
	"nvim-java/nvim-java",
	commit = require("settings.versions").nvim_java,
	enabled = require("utils.resolve_features")().java,
	config = function()
		require("java").setup({
			jdk = {
				auto_install = false,
			},
		})
		vim.lsp.enable("jdtls")
	end,
}
