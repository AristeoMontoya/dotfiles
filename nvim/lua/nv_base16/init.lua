local cmd = vim.cmd
local base16 = require "base16"
base16(base16.themes["onedark"], true)

-- Neovim
cmd("hi LineNr guibg=NONE")
cmd("hi SignColumn guibg=NONE")
cmd("hi VertSplit guibg=NONE guifg=#3e4451")
cmd("hi CursorLine guibg=#2c323c")
cmd("hi CursorLineNr gui=None guifg=#abb2bf guibg=#2c323c")
cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
cmd("hi DiffChange guifg =#3A3E44 guibg = none")
cmd("hi DiffModified guifg = #81A1C1 guibg = none")
cmd("hi EndOfBuffer guifg=#282c34")
cmd("hi Delimiter None")
cmd("hi Underlined guifg=None")
cmd("hi Error guifg=None guibg=None")

-- GitGutter
cmd("hi GitGutterAdd guibg=None")
cmd("hi GitGutterChange guibg=None")
cmd("hi GitGutterDelete guibg=None")
cmd("hi GitGutterChangeDelete guibg=None")

-- TreeSitter
cmd("hi tskeywordoperator guifg=#d291e4")
cmd("hi tstypebuiltin guifg=#c678dd")
cmd("hi tsparameter guifg=#56b6c2")
cmd("hi tstitle guifg=#e5c07b")
cmd("hi tsinclude guifg=#d291e4")
cmd("hi tsrepeat guifg=#d291e4")
cmd("hi tserror guibg=None guifg=#e06c75")
cmd("hi tscharacter guifg=#98c379")
cmd("hi tsmethod gui=bold guifg=#61afef")

-- CoC
cmd("hi pmenusel guibg=#98c379")

-- Lualine
cmd("hi lualine_y_diff_added_normal guifg=#98c379")
cmd("hi lualine_y_diff_added_inactive guifg=#98c379")

cmd("hi lualine_y_diff_modified_normal guifg=#56b6c2")
cmd("hi lualine_y_diff_modified_inactive guifg=#56b6c2")

cmd("hi lualine_y_diff_removed_normal guifg=#e06c75")
cmd("hi lualine_y_diff_removed_inactive guifg=#e06c75")

-- Bufferline
cmd("hi TabLineSel guifg=#98c379 guibg=#282c34")
cmd("hi TabLineFill guibg=#353b45")

cmd("hi BufferLineBackground guifg=#abb2bf guibg=#353b45")
cmd("hi BufferLineFill guibg=#353b45")
cmd("hi BufferLineSeparator guibg=#353b45")
cmd("hi BufferLineModified guibg=#353b45")
cmd("hi BufferLineIndicatorSelected guifg=#98c379")
cmd("hi BufferLineBufferSelected gui=bold guifg=#98c379")

-- NvimTree
cmd("hi NvimTreeFolderIcon guifg=#61AFEF")
cmd("hi NvimTreeNormal guibg=#1f2228")
cmd("hi NvimTreeCursorLine guibg=#282c34")
