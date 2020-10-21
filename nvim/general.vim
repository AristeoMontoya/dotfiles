syntax on				" Coloreo de sintaxis
colorscheme onedark		" Tema del editor

" Identación con espacios para Python
let g:indentLine_enabled = 0
" Airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_z = '%{line(".")}/%{line("$")} : %{col(".")}'
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
let g:vimwiki_diary_months	= {
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
set tabline=%!MyTabLine()	" Pestañas personalizadas
filetype plugin on			" Configuraciones de Vimwiki

function MyTabLine()
	let s = '' " complete tabline goes here
	" loop through each tab page
	for t in range(tabpagenr('$'))
		" set highlight
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		" set the tab page number (for mouse clicks)
		let s .= '%' . (t + 1) . 'T'
		let s .= ' ['
		" set page number string
		let s .= t + 1 . '] '
		" get buffer names and statuses
		let n = ''		"temp string for buffer names while we loop and check buftype
		let m = 0		" &modified counter
		let bc = len(tabpagebuflist(t + 1))		"counter to avoid last ' '
		" loop through each buffer in a tab
		for b in tabpagebuflist(t + 1)
			" buffer types: quickfix gets a [Q], help gets [H]{base fname}
			" others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
			if getbufvar( b, "&buftype" ) == 'help'
				let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
			elseif getbufvar( b, "&buftype" ) == 'quickfix'
				let n .= '[Q]'
			else
				let n .= pathshorten(bufname(b))
			endif
					" check and ++ tab's &modified count
			if getbufvar( b, "&modified" )
				let m += 1
			endif
			" no final ' ' added...formatting looks better done later
			if bc > 1
				let n .= ' '
			endif
			let bc -= 1
		endfor
		" add modified label [n+] where n pages in tab are modified
		if m > 0
			let s .= '[' . m . '+]'
		endif
		" select the highlighting for the buffer names
		" my default highlighting only underlines the active tab
		" buffer names.
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
			" add buffer names
		if n == ''
			let s.= '[New]'
		else
			let s .= n
		endif
		" switch to no underlining and add final space to buffer list
		let s .= ' '
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLineFill#%'
	endif
	return s
endfunction
