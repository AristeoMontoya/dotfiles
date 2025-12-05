return {
	"nvim-java/nvim-java",
	commit = require("settings.versions").nvim_java,
	config = function()
		require("java").setup({
			jdk = {
				auto_install = false,
			},
		})
		vim.lsp.enable("jdtls")
	end,
}
