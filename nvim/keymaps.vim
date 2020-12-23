" Cambiar de espacio en el editor
nnoremap <C-a> :e#<CR>

"				SPLITS
" ==================================
" Reducir split vertical
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

nnoremap <A-l> :vertical resize +5<CR>

" Crear Split horizontal
nnoremap <leader>sh :split<CR>

" Crear split verticarl
nnoremap <leader>sv :vs<CR>

" Rotar splits
nnoremap <leader>ss <C-W>R

" Mover split a pestaña
nnoremap <leader>st <C-W>T

" Guardar
nnoremap <C-s> :w<CR>

" Cambiar espacios por tabs
nnoremap <silent> <leader>rt :call Tabulacion()<CR>

" Búsqueda difusa
noremap <C-p> :call Fzf_dev()<CR>

" Salir de insert en terminal
tnoremap <ESC> <C-\><C-n><C-p>

" Abrir terminal
nmap <silent> Ñ :call AbrirTerminal()<CR>

" Nueva pestaña
nmap <leader>tn :tabedit<CR>

" Cerrar pestaña
nmap <leader>tk :tabclose<CR>

" Adios popó
map <left>	<nop>
map <up>	<nop>
map <down>	<nop>
map <right> <nop>

" explorador de archivos
nmap <silent><leader>fe :CocCommand explorer<CR>

" DEBUG
" Breakpoints
nmap <leader>dd <Plug>VimspectorToggleBreakpoint

" Iniciar/continuar
nmap <leader>ds <Plug>VimspectorContinue

" Detener
nmap <leader>dS <Plug>VimspectorStop

" Comentarios
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

" Sudo aunque no sudo
cmap w!! w !sudo tee %

" Git
" Git Status
nmap <silent><leader>gs :G<CR>

" Errores comunes a comandos frecuentes
:command WQ wq
:command Wq wq
:command W w
:command Q q
