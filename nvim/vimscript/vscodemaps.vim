" Navegación por tabs
nnoremap <TAB> tabnext
nnoremap <S-TAB> tabprevious

" Cambiar de espacio en el editor
nnoremap <silent> <C-a> :e#<CR>

"				SPLITS
" ==================================
" Mover a split izquierdo
nnoremap <silent> <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>

" Mover a split de abajo
nnoremap <silent> <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>

" Mover a split de arriba
nnoremap <silent> <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>

" Mover a split derecho
nnoremap <silent> <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

" Reducir split vertical
nnoremap <silent> <A-h> :vertical resize -5<CR>

" Reducir splir horizontal
nnoremap <silent> <A-j> :resize -5<CR>

" Agrandar split horizontal
nnoremap <silent> <A-k> :resize +5<CR>

" Agrandar split vertial
nnoremap <silent> <A-l> :vertical resize +5<CR>

" Crear Split horizontal
nnoremap <silent> <leader>sh <Cmd>Split<CR>

" Crear split verticarl
nnoremap <silent> <leader>sv <Cmd>Vsplit<CR>

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

" Específicas de VSCode
"" Comandos necesarios
command! -bang Find call VSCodeNotify('workbench.action.quickOpen')

"" Hover
nnoremap <K> editor.action.showHover

"" Buscador de archivos
nnoremap <leader>ff <cmd>Find<CR>
