if has('termguicolors')
	set termguicolors
endif

syntax on

set listchars=tab:\▏\ 
set iskeyword+=-
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
set cmdheight=1
filetype plugin on			" Configuraciones de Vimwiki

" Función para cambiar espacios por tabulaciones
function Tabulacion()
	set noexpandtab|retab!
endfunction

function OpenConfig()
	tabedit $CONFIGVIM/init.lua
	tcd $CONFIGVIM
endfunction

function! SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
