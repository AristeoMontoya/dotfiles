call plug#begin('~/.data/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
call plug#end()

let g:airline_powerline_fonts=1

set number
set textwidth=0
set wrapmargin=0
set tabstop=4
set shiftwidth=4
set nowrap

