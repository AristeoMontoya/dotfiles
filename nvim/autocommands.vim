" Autocmd's para lenguajes
function! Html()
	setlocal tabstop=2
	setlocal shiftwidth=2
endfunction

function! Markdown()
	let b:coc_suggest_disable = 1
	setlocal wrap
	setlocal linebreak
	setlocal nonumber
	setlocal norelativenumber
	setlocal breakindent
endfunction

function! Haskell()
	setlocal tabstop=8
	setlocal softtabstop=0
	setlocal expandtab
	setlocal shiftwidth=4
	setlocal smarttab
endfunction

function! Java()
	setlocal colorcolumn=100
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

" Auto comandos por ipo de archivo
autocmd FileType html,css call Html()
autocmd FileType markdown,vimwiki call Markdown()
autocmd FileType haskell call Haskell()
autocmd FileType python,php call Python()
autocmd FileType javascript call JS()
autocmd FileType java call Java()

" Cambiar Perl por Prolog
autocmd BufRead *.pl set filetype=prolog

" Mantener el tamaño de los splits al cambiar el tamaño de ventana
autocmd VimResized * wincmd =
