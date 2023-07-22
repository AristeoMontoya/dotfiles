local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

mason_null_ls.setup({
	handlers = {
		function(source_name, methods)
			-- all sources with no handler get passed here
		end,
		stylua = function(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.stylua)
		end,
	},
	automatic_setup = true
})

null_ls.setup {
	debug = true,
	sources = {
        formatting.google_java_format.with({
        	extra_args = { '--aosp' }
        }),
        formatting.stylua,
	},
}

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})
