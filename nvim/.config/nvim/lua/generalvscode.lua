local opt = V.opt

opt.clipboard = 'unnamedplus'
opt.ignorecase = true
opt.incsearch = true
opt.mouse = 'a'

V.g.mapleader = " "
V.api.nvim_set_keymap('n', ' ', '', {noremap = true, silent = true})
V.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
V.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})
