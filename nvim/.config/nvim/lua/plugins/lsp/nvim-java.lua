return {
	"nvim-java/nvim-java",
	commit = require("settings.versions").nvim_java,
	enabled = require("utils.config_manager").is_feature_enabled("java"),
	config = function()
		require("java").setup({
			jdk = {
				auto_install = false,
			},
			lombok = {
				enable = true,
				version = "1.18.40",
			},
		})
		vim.lsp.enable("jdtls")
	end,
}
