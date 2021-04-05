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
set tabline=%!MyTabLine()	" Pestañas personalizadas
set cmdheight=1
filetype plugin on			" Configuraciones de Vimwiki


function MyTabLine()
	let tabLineString = '' " complete tabline goes here
	" loop through each tab page
	for tab in range(tabpagenr('$'))
		" set highlight
		if tab + 1 == tabpagenr()
			let tabLineString .= '%#TabLineSel#'
		else
			let tabLineString .= '%#TabLine#'
		endif
		" set the tab page number (for mouse clicks)
		let tabLineString .= '%' . (tab + 1) . 'T'
		let tabLineString .= '['
		" set page number string
		let tabLineString .= tab + 1 . '] '
		" get buffer names and statuses
		let bufferName = ''						" temp string for buffer names while we loop and check buftype
		let modifierCount = 0					" &modified counter
		let bc = len(tabpagebuflist(tab + 1))	" counter to avoid last ' '

		" loop through each buffer in a tab
		for buffer in tabpagebuflist(tab + 1)
			" buffer types: quickfix gets a [Q], help gets [H]{base fname}
			" others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
			if getbufvar( buffer, "&buftype" ) == 'help'
				let bufferName .= '[H]' . fnamemodify( bufname(buffer), ':t:s/.txt$//' )
			elseif getbufvar( buffer, "&buftype" ) == 'quickfix'
				let bufferName .= '[Q]'
			elseif getbufvar( buffer, "&buftype" ) == 'terminal'
				let bufferName .= '[T]'
			else
				let bufferName .= pathshorten(bufname(buffer))
			endif
					" check and ++ tab's &modified count
			if getbufvar( buffer, "&modified" )
				let modifierCount += 1
			endif
			" no final ' ' added...formatting looks better done later
			if bc > 1
				let bufferName .= ' '
			endif
			let bc -= 1
		endfor
		" add modified label [n+] where n pages in tab are modified
		if modifierCount > 0
			let tabLineString .= '[' . modifierCount . '+]'
		endif
		" select the highlighting for the buffer names
		" my default highlighting only underlines the active tab
		" buffer names.
		if tab + 1 == tabpagenr()
			let tabLineString .= '%#TabLineSel#'
		else
			let tabLineString .= '%#TabLine#'
		endif
			" add buffer names
		if bufferName == ''
			let tabLineString.= '[Nuevo]'
		else
			let tabLineString .= bufferName
		endif
		" switch to no underlining and add final space to buffer list
		let tabLineString .= ' '
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let tabLineString .= '%#TabLineFill#%T'
	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let tabLineString .= '%=%#TabLineFill#%'
	endif
	return tabLineString
endfunction

" Función para cambiar espacios por tabulaciones
function Tabulacion()
	set noexpandtab|retab!
endfunction

function OpenConfig()
	tabedit $CONFIGVIM/init.vim
	tcd $CONFIGVIM
endfunction

function! SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
