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

" Guardar
nnoremap <silent> <C-s> :w<CR>

" Cambiar espacios por tabs
nnoremap <silent> <leader>rt :call Tabulacion()<CR>

command Tabulacion call Tabulacion()

" Búsqueda difusa
noremap <silent> <C-p> :call Fzf_dev()<CR>

" Salir de insert en terminal
tnoremap <silent> <ESC> <C-\><C-n><C-p>

" Abrir terminal
nmap <silent> Ñ :call AbrirTerminal()<CR>

" Nueva pestaña
nmap <silent> <leader>tn :tabedit<CR>

" Cerrar pestaña
nmap <silent> <leader>tk :tabclose<CR>

" Alternar pestañas
noremap <silent> <tab> gt

" Alternar pestañas en orden inverso
noremap <silent> <S-tab> gT

" Qutiar el marcado de coincidencias de búsqueda
noremap <silent> <leader>n :noh<CR>

" Adios popó
map <left>	<nop>
map <up>	<nop>
map <down>	<nop>
map <right>	<nop>

" Adios popó para insert
imap <left>		<nop>
imap <up>		<nop>
imap <down>		<nop>
imap <right>	<nop>

" DEBUG
" Breakpoints
nmap <leader>dd <Plug>VimspectorToggleBreakpoint

" Iniciar/continuar
nmap <leader>ds <Plug>VimspectorContinue

" Detener
nmap <leader>dS <Plug>VimspectorStop

" Comentarios
nnoremap <silent> <space>/ :Commentary<CR>
vnoremap <silent> <space>/ :Commentary<CR>

" Sudo aunque no sudo
cmap w!! w !sudo tee %

" ==========================
" 			Git
" ==========================
" Git Status
nmap <silent> <leader>gs :G<CR>

" Git log
nmap <silent> <leader>gl :GcLog<CR>

" Git blame
" Blame para modo normal
nmap <silent> <leader>gb :Git blame<CR>

" Blame para modo visual
vmap <silent> <leader>gb :Gblame<CR>

" Errores comunes a comandos frecuentes
:command WQ wq
:command Wq wq
:command W w
:command Q q
:command QA qa
:command Qa qa

" Abrir configuraciones
:command Config call OpenConfig()

nnoremap <silent> <leader>oc :Config<CR>

" Spells
" Verificar español
nnoremap <leader>ss :setlocal spell spelllang=es_mx<CR>

" Verificar inglés
nnoremap <leader>se :setlocal spell spelllang=en_us<CR>

" Dejar de verificar
nnoremap <silent> <leader>sn :setlocal nospell<CR>
