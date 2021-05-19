return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Surround
	use 'tpope/vim-surround'
	-- Explorador de archivos
	use 'kyazdani42/nvim-tree.lua'
	-- Vimwiki
	use 'vimwiki/vimwiki'
	-- Vista previa web
	use {'turbio/bracey.vim', run = 'npm install --prefix server'}
	-- Vista previa de colores
	use 'norcalli/nvim-colorizer.lua'
	-- Autocompletado
	use {'neoclide/coc.nvim', branch = 'release'}
	-- Autopares
	use 'jiangmiao/auto-pairs'
	-- Búsqueda difusa
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	-- Íconos
	use 'kyazdani42/nvim-web-devicons'
	-- Marcado de identación con espacios
	use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
	-- Vista previa de MarkDown
	use {'iamcco/markdown-preview.nvim', config = "vim.call('mkdp#util#install')" }
	-- Debugger
	use 'puremourning/vimspector'
	-- Ayuda con accesis directos
	use 'liuchengxu/vim-which-key'
	-- Parser veloz
	use 'nvim-treesitter/nvim-treesitter'
	-- Colores de TreeSitter
	use 'nvim-treesitter/playground'
	-- Integración con git
	use 'airblade/vim-gitgutter'
	-- Comentarios rápidos
	use 'tpope/vim-commentary'
	-- Integración con comandos de git
	use 'tpope/vim-fugitive'
	-- Movimiento vertical mejorado
	use 'easymotion/vim-easymotion'
	-- Línea de status
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	-- Integración con TaskWarrior
	use {'tbabej/taskwiki', opt = true, ft = {'markdown'}}
	-- OneDark
	use 'norcalli/nvim-base16.lua'
	-- Tabline
	use 'akinsho/nvim-bufferline.lua'
end)
