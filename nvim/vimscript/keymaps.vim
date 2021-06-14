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

" Salir de insert en terminal
tnoremap <silent> <ESC> <C-\><C-n><C-p>

" Abrir terminal
nmap <silent> Ñ :call AbrirTerminal()<CR>

" Nueva pestaña
nmap <silent> <leader>tn :tabedit<CR>

" Cerrar pestaña
nmap <silent> <leader>tk :tabclose<CR>

" Cerrar buffer
nmap <silent> <leader>bk :bd<CR>

" Alternar buffers
noremap <silent> <tab> :bnext<CR>

" Alternar buffers en orden inverso
noremap <silent> <S-tab> :bprevious<CR>

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

" Crear captura
:command Capture luafile ~/.config/nvim/lua/capture.lua

nnoremap <silent> <leader>c :Capture<CR>

" Spells
" Verificar español
nnoremap <leader>ss :setlocal spell spelllang=es_mx<CR>

" Verificar inglés
nnoremap <leader>se :setlocal spell spelllang=en_us<CR>

" Dejar de verificar
nnoremap <silent> <leader>sn :setlocal nospell<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Buscar capturas de notas con Telescope
nnoremap <leader>fc <cmd>lua require 'nv_telescope.finders'.find_captures()<CR>
nnoremap <leader>fd <cmd>lua require 'nv_telescope.finders'.find_definition()<CR>

" Nvim Hop
nnoremap <leader><leader>f :HopChar1<CR>
nnoremap <leader><leader>b :HopChar2<CR>

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" <Tab> para confirmar
inoremap <expr> <Tab> pumvisible() ? compe#confirm() : "\<Tab>"

" Navegar por ventana de sugerencias
" Navegar hacia abajo en la lista
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"

" Navegar hacia arriba en la lista
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" Autocompletado con Ctrl + espacio
inoremap <silent><expr> <c-space> compe#complete()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
