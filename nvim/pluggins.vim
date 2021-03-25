"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if has('termguicolors')
	set termguicolors
endif

call plug#begin('~/.data/plugged')
	" El mejor plugin de todos
	Plug 'tpope/vim-surround'
	if !exists('g:vscode')
		" Vista previa web
		Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
		" Vista previa de colores
		Plug 'norcalli/nvim-colorizer.lua'
		" Autocompletado
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
		" Autopares
		Plug 'jiangmiao/auto-pairs'
		" Búsqueda difusa
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'
		" Llaves con colores
		Plug 'luochen1990/rainbow'
		" Íconos
		Plug 'kyazdani42/nvim-web-devicons'
		" Marcado de identación con espacios
		Plug 'Yggdroot/indentLine'
		" Vista previa de MarkDown
		Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
		" Debugger
		Plug 'puremourning/vimspector'
		" Ayuda con accesis directos
		Plug 'liuchengxu/vim-which-key'
		" Parser veloz
		Plug 'nvim-treesitter/nvim-treesitter'
		" Colores de TreeSitter
		Plug 'nvim-treesitter/playground'
		" Integración con git
		Plug 'airblade/vim-gitgutter'
		" Comentarios rápidos
		Plug 'tpope/vim-commentary'
		" Integración con comandos de git
		Plug 'tpope/vim-fugitive'
		" Movimiento vertical mejorado
		Plug 'easymotion/vim-easymotion'
		" OneDark
		Plug 'tjdevries/colorbuddy.nvim'
		Plug 'Th3Whit3Wolf/onebuddy'
		" Línea de status
		Plug 'hoob3rt/lualine.nvim'
		" Vimwiki
		Plug 'vimwiki/vimwiki'
		" Integración con TaskWarrior
		Plug 'tbabej/taskwiki'
		" Lineas de identación vacías
		" Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
	endif
call plug#end()

if !exists('g:vscode')
	lua require('colorbuddy').colorscheme('onebuddy')

	" Identación con espacios para Python y JS
	" Desactivado por defecto. Se activa por AutoCMD
	let g:indentLine_enabled = 0

	" Marcar el primer nivel de identación
	let g:indentLine_showFirstIndentLevel=1
endif
