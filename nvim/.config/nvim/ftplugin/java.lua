-- TS Highlights
vim.api.nvim_set_hl(0, "@variable.member.java", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@variable.parameter.java", { link = "Constant" })
vim.api.nvim_set_hl(0, "@import.path.java", { link = "Constant" })

-- LSP Highlights
vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.java", { link = "Constant" })
