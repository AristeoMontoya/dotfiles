source ~/.config/nvim/generalvscode.vim
source ~/.config/nvim/pluggins.vim
if !exists('g:vscode')
	source ~/.config/nvim/general.vim
	" Pluggins
	" ------------------------------------
	luafile ~/.config/nvim/treeSitter.lua
	luafile ~/.config/nvim/lualine.lua
	luafile ~/.config/nvim/colorizer.lua
	luafile ~/.config/nvim/telescope.lua
	source ~/.config/nvim/indentLine.vim
	" source ~/.config/nvim/rainbow.lua
	source ~/.config/nvim/coc.vim
	source ~/.config/nvim/whichkey.vim
	source ~/.config/nvim/gitgutter.vim
	source ~/.config/nvim/vimspector.vim
	source ~/.config/nvim/vimwiki.vim
	" ------------------------------------
	source ~/.config/nvim/keymaps.vim
	source ~/.config/nvim/autocommands.vim
	luafile ~/.config/nvim/base16.lua
endif
