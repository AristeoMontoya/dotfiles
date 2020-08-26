set clipboard+=unnamedplus
set ignorecase
set incsearch
set mouse=a
vmap < <gv
vmap > >gv
if !exists('g:vscode')
	call plug#begin('~/.data/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'turbio/bracey.vim'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ap/vim-css-color'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'joshdick/onedark.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'jiangmiao/auto-pairs'
	Plug 'vim-syntastic/syntastic'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
	Plug 'junegunn/fzf.vim'
	Plug 'alok/notational-fzf-vim'
	Plug 'frazrepo/vim-rainbow'
	Plug 'ryanoasis/vim-devicons'
	Plug 'vimwiki/vimwiki'
	Plug 'preservim/nerdcommenter'
	Plug 'Yggdroot/indentLine'
	Plug 'uiiaoo/java-syntax.vim'
	call plug#end()

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
		set shiftwidth = 4
		set smarttab
	endfunction

	function! Terminal()
		belowright split
		terminal
		res 8
		set norelativenumber
		set nonumber
	endfunction

	function! Python()
		let g:indentLine_enabled = 1
		set nolist
	endfunction

	syntax on
	colorscheme onedark
	let g:indentLine_enabled = 0
	let g:airline_powerline_fonts = 1
	let g:airline_section_z = '%{line(".")}/%{line("$")} : %{col(".")}'
	let mapleader="\ "
	let g:nv_search_paths = ['~/vimwiki']
	let g:fzf_preview_command = 'bat --color=always --style=grid --theme=OneHalfDark {-1}'
	let g:rainbow_guifgs = ['#E5C07B', '#C678DD', '#61AFEF', '#FF7A85']
	let g:vimwiki_folding='syntax'
	let wiki = { }
	let wiki.path = '~/vimwiki/'
	let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'js': 'javascript',
	\ 'java': 'java', 'sql': 'sql', 'css': 'css', 'html': 'html', 'hskl': 'haskell',
	\ 'arduino': 'arduino', 'php': 'php', 'json': 'json', 'sh': 'sh'
	\}
	let g:vimwiki_list = [wiki]
	let g:vimwiki_diary_months  = {
	\ 1: 'Enero', 2: 'Febrero', 3: 'Marzo',
	\ 4: 'Abril', 5: 'Mayo', 6: 'Junio',
	\ 7: 'Julio', 8: 'Agosto', 9: 'Septiembre',
	\ 10: 'Octubre', 11: 'Noviembre', 12: 'Diciembre'
	\ }
	set listchars=tab:\¦\ 
	set list
	set splitright
	set cursorline
	set splitbelow
	set smartindent
	set autoindent
	set number relativenumber
	set noswapfile
	set textwidth=0
	set wrapmargin=0
	set noexpandtab
	set copyindent
	set preserveindent
	set tabstop=4
	set shiftwidth=4
	set nowrap
	set nocompatible
	filetype plugin on
	autocmd filetype html,css call Html()
	autocmd filetype markdown,vimwiki call Markdown()
	autocmd filetype haskell call Haskell()
	autocmd filetype python call Python()
	autocmd BufRead *.pl set filetype=prolog
	autocmd FileType * if &ft !~ 'html\|css\|vimwiki\|text\|help\|haskell\|sql' | :call rainbow#load() | endif
	nnoremap <C-a> :e#<CR>
	" Cambiar de espacio en el editor
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l
	nnoremap <A-h> :vertical resize -5<CR>
	nnoremap <A-j> :resize -5<CR>
	nnoremap <A-k> :resize +5<CR>
	nnoremap <A-l> :vertical resize +5<CR>
	nnoremap <C-s> :w<CR>
	noremap <C-p> :call Fzf_dev()<CR>
	tnoremap <ESC> <C-\><C-n><C-p>
	nmap Ñ :call Terminal()<CR>
	map <C-f> <Plug>NERDCommenterToggle
	hi def VimwikiHeader1 guifg=#61AFEF
	hi def VimwikiHeader3 guifg=#E5C07B
	hi def VimwikiHeader4 guifg=#E5C07B
	hi def VimwikiHeader5 guifg=#E5C07B
	hi def VimwikiHeader6 guifg=#E5C07B
	hi def VimwikiBold gui=bold guifg=#FFFFFF
	hi def VimwikiBoldItalic gui=bold,italic guifg=#FFFFFF
	hi def VimwikiCode guifg=#E48AFF

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
		elseif system("git -C . rev-parse") && v:shell_error == 1
			" Si el directorio es un repositorio se usa GFiles
			echo 'En repo'
		else
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

	"A partir de aquí comienza la configuración de CoC"
	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" Give more space for displaying messages.
	set cmdheight=2

	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <" ">
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<" ">" :
		\ coc#refresh()
	inoremap <expr><S-" "> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	"if has('patch8.1.1068')
		" Use `complete_info` if your (Neo)Vim version supports it.
		" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	"else
		"imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	"endif

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current line.
	nmap <leader>ac  <Plug>(coc-codeaction)

	" Apply AutoFix to problem on the current line.
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Introduce function text object
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)
endif
