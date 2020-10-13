syntax on				" Coloreo de sintaxis
colorscheme onedark		" Tema del editor

" Identación con espacios para Python
let g:indentLine_enabled = 0
" Airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_z = '%{line(".")}/%{line("$")} : %{col(".")}'
let mapleader="\ "
let g:nv_search_paths = ['~/vimwiki']
let g:fzf_preview_command = 'bat --color=always --style=grid --theme=OneHalfDark {-1}'
let g:rainbow_guifgs = ['#E5C07B', '#C678DD', '#61AFEF', '#FF7A85']
let wiki = { }
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'js': 'javascript',
\ 'java': 'java', 'sql': 'sql', 'css': 'css', 'html': 'html', 'hskl': 'haskell',
\ 'arduino': 'arduino', 'php': 'php', 'json': 'json', 'sh': 'sh'
\}
let g:vimwiki_list = [wiki]
let g:vimwiki_diary_months  = {
\ 1: 'Enero', 2: 'Febrero', 3: 'Marzo',
\ 4: 'Abril', 5: 'Mayo', 6: 'Junio',
\ 7: 'Julio', 8: 'Agosto', 9: 'Septiembre',
\ 10: 'Octubre', 11: 'Noviembre', 12: 'Diciembre'
\ }

set listchars=tab:\¦\ 
set list					" Caracter para identación
set noshowmode				" No mostrar el mensaje de modo actual
set splitright				" Abrir Split vertical a la derecha
set splitbelow				" Abrir splir horizontal abajo
set cursorline				" Color diferente para la línea donde está el cursor
set smartindent				" Identación automática después de abrir llaves
set autoindent				" Identación automática
set number relativenumber	" Números de línea relativos
set noswapfile				" Evita la cración de archivos swap
set textwidth=0				" Tamaño máximo de una línea antes de dividirse
set wrapmargin=0			" Número de caracteres donde se termina la línea
set noexpandtab				" No convertir identación en espacios
set copyindent				" Copia la identación existente cuando se hace una nueva línea
set preserveindent			" Preserva la tabulación anterior en la siguiente línea
set tabstop=4				" Tamaño de tabulación
set shiftwidth=4			" Tamaño de tabulación
set nowrap					" Evita que las líneas se divivan si excede el ancho
set nocompatible			" Configuraciones de VimWiki
filetype plugin on			" Configuraciones de Vimwiki

" Cosas de LSP
"lua require'nvim_lsp'.tsserver.setup{ on_attach=require'completion'.on_attach }
