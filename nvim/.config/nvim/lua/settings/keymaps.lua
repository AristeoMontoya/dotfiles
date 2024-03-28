local map = V.api.nvim_set_keymap
local setmap = V.keymap.set

local defaults = {
	noremap = true,
	silent = true
}

-- Go to previous file
map('n', '<C-a', ':e#<CR>', defaults)

-- Center buffer after next occurrence
map('n', 'n', 'nzz', defaults)
map('n', 'N', 'Nzz', defaults)

-- Center buffer after page movement
map('n', '<C-d>', '<C-d>zz', defaults)
map('n', '<C-u>', '<C-u>zz', defaults)

-- Center after joining lines
map('n', 'J', 'mzJ`z', defaults)

-- Copy to the end of line
map('n', 'Y', 'y$', defaults)

-- Split movements
setmap('n', '<A-h>', require('smart-splits').move_cursor_left)
setmap('n', '<A-j>', require('smart-splits').move_cursor_down)
setmap('n', '<A-k>', require('smart-splits').move_cursor_up)
setmap('n', '<A-l>', require('smart-splits').move_cursor_right)

-- Split resize
setmap('n', '<C-A-h>', require('smart-splits').resize_left)
setmap('n', '<C-A-j>', require('smart-splits').resize_down)
setmap('n', '<C-A-k>', require('smart-splits').resize_up)
setmap('n', '<C-A-l>', require('smart-splits').resize_right)

-- moving between splits
-- swapping buffers between windows
setmap('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
setmap('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
setmap('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
setmap('n', '<leader><leader>l', require('smart-splits').swap_buf_right)


-- Split creation
map('n', '<leader>sh', ':split<CR>', defaults)
map('n', '<leader>sv', ':vs<CR>', defaults)

-- Split rotation
map('n', '<leader>sr', '<C-W>R', defaults)

-- Split to tab
map('n', '<leader>st', '<C-W>T', defaults)

-- Save buffer
map('n', '<C-s>', ':w<CR>', defaults)

-- Close buffer
map('n', '<leader>bk', ':bd<CR>', defaults)

-- Alternate buffer
map('n', '<tab>', ':bnext<CR>', defaults)
map('n', '<S-tab>', ':bprevious<CR>', defaults)

-- Disable arrow keys
map('n', '<left>', '<nop>', {})
map('n', '<right>', '<nop>', {})
map('n', '<up>', '<nop>', {})
map('n', '<down>', '<nop>', {})

map('i', '<left>', '<nop>', {})
map('i', '<right>', '<nop>', {})
map('i', '<up>', '<nop>', {})
map('i', '<down>', '<nop>', {})

-- Spells
map('n', '<leader>vs', ':setlocal spell spelllang=es_mx<CR>', {noremap = true})
map('n', '<leader>ve', ':setlocal spell spelllang=en_us<CR>', {noremap = true})
map('n', '<leader>vn', ':setlocal nospell<CR>', defaults)

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', defaults)
map('n', '<leader>fg', ':Telescope live_grep<CR>', defaults)
map('n', '<leader>fb', ':Telescope buffers<CR>', defaults)
map('n', '<leader>fh', ':Telescope help_tags<CR>', defaults)

-- NvimTree
map('n', '<leader>fe', ':NvimTreeToggle<CR>', defaults)

-- Trouble
map('n', '<leader>ld', ':TroubleToggle<CR>', defaults)

-- Svart
map('n', 's', ':Svart<CR>', defaults)
map('n', 'S', ':SvartRegex<CR>', defaults)
map('n', 'gs', ':SvartRepeat<CR>', defaults)

-- Luasnip choice nodes
map("i", "<C-n>", "<Plug>luasnip-next-choice", defaults)
map("s", "<C-n>", "<Plug>luasnip-next-choice", defaults)
map("i", "<C-p>", "<Plug>luasnip-prev-choice", defaults)
map("s", "<C-p>", "<Plug>luasnip-prev-choice", defaults)

-- format
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", defaults)
