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
	source ~/.config/nvim/rainbow.vim
	source ~/.config/nvim/coc.vim
	source ~/.config/nvim/whichkey.vim
	source ~/.config/nvim/gitgutter.vim
	source ~/.config/nvim/vimspector.vim
	source ~/.config/nvim/vimwiki.vim
	" ------------------------------------
	source ~/.config/nvim/keymaps.vim
	source ~/.config/nvim/autocommands.vim
	"a
endif
