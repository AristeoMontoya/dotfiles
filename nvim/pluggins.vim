"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if has("termguicolors")
	set termguicolors
endif

call plug#begin('~/.data/plugged')
	if !exists('g:vscode')
		Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'ap/vim-css-color'
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
		Plug 'joshdick/onedark.vim'
		Plug 'jiangmiao/auto-pairs'
		Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
		Plug 'junegunn/fzf.vim'
		Plug 'alok/notational-fzf-vim'
		Plug 'luochen1990/rainbow'
		Plug 'ryanoasis/vim-devicons'
		Plug 'vimwiki/vimwiki'
		Plug 'Yggdroot/indentLine'
		Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
		Plug 'puremourning/vimspector'
		Plug 'liuchengxu/vim-which-key'
		Plug 'nvim-treesitter/nvim-treesitter'
		Plug 'ThePrimeagen/vim-be-good'
		Plug 'airblade/vim-gitgutter'
		Plug 'tpope/vim-commentary'
		Plug 'tpope/vim-fugitive'
	endif
	Plug 'tpope/vim-surround'
call plug#end()

if !exists('g:vscode')

	let g:airline#extensions#hunks#enabled = 0

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

	lua << EOF
	require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
highlight = {
	enable = true			   -- false will disable the whole extension
	},
	indent = {
enable = true
}
}
require"nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
EOF
	let g:rainbow_active = 1
endif
