source ~/.config/nvim/generalvscode.vim
if !exists('g:vscode')
	source ~/.config/nvim/pluggins.vim
	source ~/.config/nvim/coc.vim
	source ~/.config/nvim/general.vim
	source ~/.config/nvim/keymaps.vim
	source ~/.config/nvim/autocommands.vim
endif
