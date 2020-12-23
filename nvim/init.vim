source ~/.config/nvim/generalvscode.vim
source ~/.config/nvim/pluggins.vim
if !exists('g:vscode')
	source ~/.config/nvim/general.vim
	source ~/.config/nvim/coc.vim
	source ~/.config/nvim/keymaps.vim
	source ~/.config/nvim/autocommands.vim
	source ~/.config/nvim/whichkey.vim
	source ~/.config/nvim/gitgutter.vim
	source ~/.config/nvim/vimspector.vim
endif
