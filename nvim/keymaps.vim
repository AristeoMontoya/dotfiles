" Cambiar de espacio en el editor
nnoremap <C-a> :e#<CR>

" Mover a split izquierdo
nnoremap <C-h> <C-w>h

" Mover a split de abajo
nnoremap <C-j> <C-w>j

" Mover a split de arriba
nnoremap <C-k> <C-w>k

" Mover a split derecho
nnoremap <C-l> <C-w>l

" Reducir split vertical
nnoremap <A-h> :vertical resize -5<CR>

" Reducir splir horizontal
nnoremap <A-j> :resize -5<CR>

" Agrandar split horizontal
nnoremap <A-k> :resize +5<CR>

" Reducir split vertical
nnoremap <A-l> :vertical resize +5<CR>

" Guardar
nnoremap <C-s> :w<CR>

" Búsqueda difusa
noremap <C-p> :call Fzf_dev()<CR>

tnoremap <ESC> <C-\><C-n><C-p>

" Abrir terminal
nmap Ñ :call AbrirTerminal()<CR>

" comentar línea
nmap <space>cc <Plug>N

" Nueva pestaña
nmap <space>tn :tabedit<CR>

" Cerrar pestaña
nmap <space>tk :tabclose<CR>

" Adios popó
map <left> <nop>
map <up> <nop>
map <down> <nop>
map <right> <nop>
