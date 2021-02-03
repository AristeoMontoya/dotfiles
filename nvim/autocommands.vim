" Autocmd's para lenguajes
function! Txt()
	let b:indentLine_enabled=1
	setlocal expandtab
	setlocal nolist
endfunction

function! Html()
	setlocal tabstop=2
	setlocal shiftwidth=2
endfunction

function! Markdown()
	let b:indentLine_enabled=1
	let b:coc_suggest_disable = 1
	setlocal wrap
	setlocal linebreak
	setlocal nonumber
	setlocal norelativenumber
	setlocal breakindent
	setlocal expandtab
	setlocal nolist
	call Direcciones()
endfunction

function! Haskell()
	setlocal tabstop=8
	setlocal softtabstop=0
	setlocal expandtab
	setlocal shiftwidth=4
	setlocal smarttab
	setlocal nolist
endfunction

function! Java()
	setlocal colorcolumn=100
endfunction

" Función para arreglar la identación de PHP
function! Php()
	setlocal indentexpr =
	setlocal autoindent
	setlocal smartindent
endfunction

function! Python()
	let b:indentLine_enabled=1
	setlocal shiftwidth=4
	setlocal colorcolumn=80
	setlocal nolist
endfunction

function! JS()
	let b:indentLine_enabled=1
	setlocal shiftwidth=2
	setlocal colorcolumn=80
	setlocal nolist
	setlocal expandtab
endfunction

" Función para abrir terminal debajo de la ventana
function! AbrirTerminal()
	botright split
	terminal
	res 8
	setlocal nonumber
	setlocal norelativenumber
	startinsert
endfunction

function Direcciones()
	" Miren quien regresa arrastrándose
	map <buffer> <left>		<left>
	map <buffer> <up>		<up>
	map <buffer> <down>		<down>
	map <buffer> <right>	<right>

	imap <buffer> <left>	<left>
	imap <buffer> <up>		<up>
	imap <buffer> <down>	<down>
	imap <buffer> <right> 	<right>
endfunction

" Auto comandos por tipo de archivo
autocmd FileType text call Txt()
autocmd FileType html,css call Html()
autocmd FileType markdown,vimwiki call Markdown()
autocmd FileType haskell call Haskell()
autocmd FileType python,rust call Python()
autocmd FileType javascript call JS()
autocmd FileType java call Java()
autocmd FileType php call Php()

" Cambiar Perl por Prolog
autocmd BufRead *.pl set filetype=prolog

" Mantener el tamaño de los splits al cambiar el tamaño de ventana
autocmd VimResized * wincmd =
