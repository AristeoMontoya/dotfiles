local map = V.api.nvim_set_keymap

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
map('n', '<C-h>', '<C-w>h', defaults)
map('n', '<C-j>', '<C-w>j', defaults)
map('n', '<C-k>', '<C-w>k', defaults)
map('n', '<C-l>', '<C-w>l', defaults)

-- Split resize
map('n', '<A-h>', ':vertical resize -5<CR>', defaults)
map('n', '<A-j>', ':resize -5<CR>', defaults)
map('n', '<A-k>', ':resize +5<CR>', defaults)
map('n', '<A-l>', ':vertical resize +5<CR>', defaults)

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

-- NEED TO REDO MY CAPTURES
-- :command Capture luafile ~/.config/nvim/lua/capture.lua
-- nnoremap <silent> <leader>c :Capture<CR>

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
