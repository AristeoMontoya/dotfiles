require("settings.clipboard")

local opt = V.opt
local gopt = V.opt_global
local g = V.g

g.mapleader = " "

opt.listchars = { tab = "▏  " }
opt.signcolumn = "yes"

opt.termguicolors = true
opt.mouse = "a"
opt.syntax = "on"
opt.signcolumn = "yes"
opt.iskeyword:append({ "-" })
opt.list = true
opt.showmode = false
opt.splitright = true
opt.splitbelow = true
opt.cursorline = true

opt.number = true
opt.relativenumber = true
opt.swapfile = false
opt.textwidth = 0
opt.wrapmargin = 0
opt.expandtab = false
opt.copyindent = true
opt.preserveindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.wrap = false
opt.compatible = false
opt.cmdheight = 1
opt.pumheight = 12
opt.laststatus = 3
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.autoindent = true

gopt.scrolloff = 3
