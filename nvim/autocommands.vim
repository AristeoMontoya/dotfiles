" Autocmd's para lenguajes
function! Txt()
	setlocal scrolloff=2
	setlocal expandtab
	setlocal nolist
endfunction

function! Html()
	setlocal tabstop=2
	setlocal shiftwidth=2
endfunction

function! Markdown()
	let b:coc_suggest_disable = 1
	let g:indentLine_setConceal = 0
	setlocal wrap
	setlocal linebreak
	setlocal nonumber
	setlocal norelativenumber
	setlocal breakindent
	setlocal expandtab
	setlocal nolist
	nnoremap <buffer> j gj
	nnoremap <buffer> k gk
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
	setlocal shiftwidth=4
	setlocal colorcolumn=80
	setlocal nolist
endfunction

function! JS()
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
autocmd FileType vue call JS()
autocmd FileType java call Java()
autocmd FileType php call Php()

" Cambiar Perl por Prolog
autocmd BufRead *.pl set filetype=prolog

" Mantener el tamaño de los splits al cambiar el tamaño de ventana
autocmd VimResized * wincmd =

" Mantener dos líneas extra verticales. Más fácil escribir.
autocmd BufEnter *.md set scrolloff=2
autocmd BufLeave *.md set scrolloff=0
