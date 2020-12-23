"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if has('termguicolors')
	set termguicolors
endif

call plug#begin('~/.data/plugged')
	if !exists('g:vscode')
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'ap/vim-css-color'
		Plug 'joshdick/onedark.vim'
		Plug 'jiangmiao/auto-pairs'
		Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
		Plug 'junegunn/fzf.vim'
		Plug 'alok/notational-fzf-vim'
		Plug 'luochen1990/rainbow'
		Plug 'ryanoasis/vim-devicons'
		Plug 'vimwiki/vimwiki'
		Plug 'Yggdroot/indentLine'
		Plug 'liuchengxu/vim-which-key'
		Plug 'airblade/vim-gitgutter'
		Plug 'tpope/vim-commentary'
		Plug 'tpope/vim-fugitive'
		Plug 'easymotion/vim-easymotion'
		Plug 'endel/vim-github-colorscheme'
	endif
	Plug 'tpope/vim-surround'
call plug#end()

if !exists('g:vscode')
	" Conteo de hunks en AirLine
	let g:airline#extensions#hunks#enabled = 0

	" Identación con espacios para Python
	let g:indentLine_enabled = 0

	" Airline
	let g:airline_powerline_fonts = 1
	let g:airline_left_sep = ''
	let g:airline_right_sep = ''
	let g:airline_section_z = '%{line(".")}/%{line("$")} : %{col(".")}'
	let g:nv_search_paths = ['~/vimwiki']
	let g:fzf_preview_command = 'bat --color=always --style=grid --theme=OneHalfDark {-1}'
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

	" Definiciones de VimWiki
	hi def VimwikiHeader1 guifg=#61AFEF
	hi def VimwikiHeader3 guifg=#E5C07B
	hi def VimwikiHeader4 guifg=#E5C07B
	hi def VimwikiHeader5 guifg=#E5C07B
	hi def VimwikiHeader6 guifg=#E5C07B
	hi def VimwikiBold gui=bold guifg=#FFFFFF
	hi def VimwikiBoldItalic gui=bold,italic guifg=#FFFFFF
	hi def VimwikiCode guifg=#E48AFF
	hi link VimwikiPre VimwikiCheckBoxDone

	"ripgrep
	if executable('rg')
		let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
		set grepprg=rg\ --vimgrep
		command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
	endif

	" Files + devicons
	function! Fzf_dev()
		if &ft == 'vimwiki'
			"Si está en VimWiki, se busca en notas únicamente
			NV
		elseif len(system("git -C . rev-parse")) < 1
			" Si el directorio es un repositorio se usa GFiles
			GFiles
		elseif system('echo -n $PWD') != '/home/aristeo'
			let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

			function! s:files()
				let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
				return s:prepend_icon(l:files)
			endfunction

			function! s:prepend_icon(candidates)
				let l:result = []
				for l:candidate in a:candidates
					let l:filename = fnamemodify(l:candidate, ':p:t')
					let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
					call add(l:result, printf('%s %s', l:icon, l:candidate))
				endfor

				return l:result
			endfunction

			function! s:edit_file(item)
				let l:pos = stridx(a:item, ' ')
				let l:file_path = a:item[pos+1:-1]
				execute 'silent e' l:file_path
			endfunction

			call fzf#run({
				\ 'source': <sid>files(),
				\ 'sink':	function('s:edit_file'),
				\ 'options': '-m ' . l:fzf_files_options,
				\ 'down':	 '40%' })
		else
			echo 'No se puede hacer búsqueda difusa en home.'
		endif
	endfunction

	let g:rainbow_conf = {
				\'guifgs': ['#E5C07B', '#C678DD', '#61AFEF', '#FF7A85'],
				\'separately': {
				\		'*':{},
				\		'html': 0,
				\		'css': 0,
				\		'text': 0,
				\		'vimwiki': 0,
				\		'help': 0,
				\		'haskell': 0,
				\		'sql': 0,
				\		'prolog': 0,
				\		'php': 0,
				\		'blade': 0
				\	}
				\}

	" Cargando configuraciones de Tree sitter
	let g:rainbow_active = 1
endif
