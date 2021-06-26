" Navegación por tabs
nnoremap <TAB> :tabnext<CR>
nnoremap <S-TAB> :tabprevious<CR>

" Cambiar de espacio en el editor
nnoremap <silent> <C-a> :e#<CR>

"				SPLITS
" ==================================
" Mover a split izquierdo
nnoremap <silent> <C-h> <C-w>h

" Mover a split de abajo
nnoremap <silent> <C-j> <C-w>j

" Mover a split de arriba
nnoremap <silent> <C-k> <C-w>k

" Mover a split derecho
nnoremap <silent> <C-l> <C-w>l

" Reducir split vertical
nnoremap <silent> <A-h> :vertical resize -5<CR>

" Reducir splir horizontal
nnoremap <silent> <A-j> :resize -5<CR>

" Agrandar split horizontal
nnoremap <silent> <A-k> :resize +5<CR>

" Agrandar split vertial
nnoremap <silent> <A-l> :vertical resize +5<CR>

" Crear Split horizontal
nnoremap <silent> <leader>sh :split<CR>

" Crear split verticarl
nnoremap <silent> <leader>sv :vs<CR>

" Rotar splits
nnoremap <silent> <leader>sr <C-W>R

" Mover split a pestaña
nnoremap <silent> <leader>st <C-W>T

" Nueva pestaña
nmap <silent> <leader>tn :tabedit<CR>

" Cerrar pestaña
nmap <silent> <leader>tk :tabclose<CR>

" Nvim Hop
nnoremap <leader><leader>f :HopChar1<CR>
nnoremap <leader><leader>b :HopChar2<CR>
