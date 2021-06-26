require('globals')

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
	-- Surround
	use {'tpope/vim-surround'}

	-- Movimiento vertical mejorado
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
    		-- you can configure Hop the way you like here; see :h hop-config
    		require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}

	if VSCODE ~= 1 then
		-- Packer can manage itself
		use {'wbthomason/packer.nvim'}
		-- Explorador de archivos
		use {'kyazdani42/nvim-tree.lua'}
		-- Vimwiki
		use {'vimwiki/vimwiki'}
		-- Vista previa web
		use {'turbio/bracey.vim', run = 'npm install --prefix server'}
		-- Vista previa de colores
		use {'norcalli/nvim-colorizer.lua'}
		-- Autocompletado
		-- use {'neoclide/coc.nvim', branch = 'release'}
		-- Autopares
		use 'jiangmiao/auto-pairs'
		-- Búsqueda difusa
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
		}
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
		-- Snippets
		use 'SirVer/ultisnips'
		-- LSP
		use 'neovim/nvim-lspconfig'
		use 'hrsh7th/nvim-compe'
    	use 'glepnir/lspsaga.nvim'
    	use 'kabouzeid/nvim-lspinstall'
		-- Java
		use 'mfussenegger/nvim-jdtls'
	end
end)
