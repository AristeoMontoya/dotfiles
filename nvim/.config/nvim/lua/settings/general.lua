local opt = V.opt
local g = V.g

g.mapleader = " "

opt.listchars = { tab = "▏  " }
opt.signcolumn = "yes"

local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}

opt.clipboard:append({ "unnamed", "unnamedplus" })

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
