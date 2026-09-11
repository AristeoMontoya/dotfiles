-- markdown conventions
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.number = false
vim.opt_local.relativenumber = false

-- disable wrap while inside a table, since wrapping mangles table alignment
local group = vim.api.nvim_create_augroup("markdown_table_wrap", { clear = false })
vim.api.nvim_clear_autocmds({ group = group, buffer = 0 })
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = group,
  buffer = 0,
  callback = function()
    local ok, node = pcall(vim.treesitter.get_node)
    local in_table = ok and node and node:type():match("^pipe_table") ~= nil
    vim.opt_local.wrap = not in_table
  end,
})
