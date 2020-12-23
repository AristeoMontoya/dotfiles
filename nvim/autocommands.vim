function! Html()
	setlocal tabstop=2
	setlocal shiftwidth=2
endfunction

function! Markdown()
	CocDisable
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

function! AbrirTerminal()
	botright split
	terminal
	res 8
	setlocal nonumber
	setlocal norelativenumber
	startinsert
endfunction

function! Python()
	let g:indentLine_enabled=1
	setlocal shiftwidth=4
	setlocal colorcolumn=80
	setlocal nolist
endfunction

autocmd FileType html,css call Html()
autocmd FileType markdown,vimwiki call Markdown()
autocmd FileType haskell call Haskell()
autocmd FileType python,php call Python()
autocmd BufRead *.pl set filetype=prolog
autocmd VimResized * wincmd =
