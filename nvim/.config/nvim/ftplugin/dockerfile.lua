-- @image.name
-- @image.tag
--
vim.api.nvim_set_hl(0, "@image.name", { link = "Type" })
vim.api.nvim_set_hl(0, "@image.tag", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@image.alias", { link = "Structure" })

-- Disabling lsp highlihgt in commands so we can inject bash
vim.api.nvim_set_hl(0, "@lsp.type.parameter.dockerfile", {})
