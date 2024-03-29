" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" " <Tab> para confirmar
" inoremap <expr> <Tab> pumvisible() ? compe#confirm() : "\<Tab>"

" " Navegar por ventana de sugerencias
" " Navegar hacia abajo en la lista
" inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"

" " Navegar hacia arriba en la lista
" inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" " Autocompletado con Ctrl + espacio
" inoremap <silent><expr> <c-space> compe#complete()

" " Rename
" noremap <silent><leader>rn :Lspsaga rename<CR>

" function! s:check_back_space() abort
" 	let col = col('.') - 1
" 	return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" " Use <Tab> for confirm completion.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
