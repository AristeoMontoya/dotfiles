source ~/.config/nvim/generalvscode.vim
source ~/.config/nvim/pluggins.vim
if !exists('g:vscode')
	source ~/.config/nvim/coc.vim
	source ~/.config/nvim/general.vim
	source ~/.config/nvim/keymaps.vim
	source ~/.config/nvim/autocommands.vim
endif
