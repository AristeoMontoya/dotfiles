if !exists('g:vscode')
	let g:polyglot_disabled = ['python-indent', 'python-compiler']
endif

call plug#begin('~/.data/plugged')
	if !exists('g:vscode')
		Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'ap/vim-css-color'
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
		Plug 'joshdick/onedark.vim'
		Plug 'sheerun/vim-polyglot'
		Plug 'jiangmiao/auto-pairs'
		Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
		Plug 'junegunn/fzf.vim'
		Plug 'alok/notational-fzf-vim'
		Plug 'frazrepo/vim-rainbow'
		Plug 'ryanoasis/vim-devicons'
		Plug 'vimwiki/vimwiki'
		Plug 'Yggdroot/indentLine'
		Plug 'uiiaoo/java-syntax.vim'
		Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
		Plug 'puremourning/vimspector'
		Plug 'liuchengxu/vim-which-key'
		Plug 'szw/vim-maximizer'
	endif
	Plug 'tpope/vim-surround'
call plug#end()

if !exists('g:vscode')

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
				\ 'sink':   function('s:edit_file'),
				\ 'options': '-m ' . l:fzf_files_options,
				\ 'down':    '40%' })
		else
			echo 'No se puede hacer búsqueda difusa en home.'
		endif
	endfunction

	"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
	"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
	"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
	if (has("nvim"))
		"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif

	"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	if (has("termguicolors"))
		set termguicolors
	endif
endif
