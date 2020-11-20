function! Html()
	set tabstop=2
	set shiftwidth=2
endfunction

function! Markdown()
	CocDisable
	set wrap
	set linebreak
	set nonumber
	set norelativenumber
	set breakindent
endfunction

function! Haskell()
	set tabstop=8
	set softtabstop=0
	set expandtab
	set shiftwidth=4
	set smarttab
endfunction

function! AbrirTerminal()
	botright split
	terminal
	res 8
	set norelativenumber
	set nonumber
endfunction

function! Python()
	let g:indentLine_enabled=1
	set shiftwidth=4
	set nolist
endfunction

function! Terminal()
	set nonumber
	set norelativenumber
	startinsert
endfunction

function! CerrarTerminal()
	set number
	set relativenumber
endfunction

autocmd FileType html,css call Html()
autocmd FileType markdown,vimwiki call Markdown()
autocmd FileType haskell call Haskell()
autocmd FileType python,php call Python()
autocmd BufRead *.pl set filetype=prolog
autocmd TermOpen * call Terminal()
autocmd TermClose call CerrarTerminal()
autocmd VimResized * wincmd =
