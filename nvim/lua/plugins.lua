require('globals')

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

local function isNodeAvailable()
	return HAS_NODE
end

local function CoC_enabled()
	return COC and isNodeAvailable()
end

return require('packer').startup(function(use)
	-- Surround
	use {'tpope/vim-surround'}

	use {
		'asvetliakov/vim-easymotion',
		opt = true,
		cond = function()
			-- Parece que es necesaria esta función para determinar
			-- cuando es válido y cuando no usar este plugin.
			return VSCODE == 1
		end
	}

	if VSCODE ~= 1 then
		-- Movimiento vertical mejorado
		use {
			'phaazon/hop.nvim',
			as = 'hop',
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
			end
		}
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
		use {
			'lukas-reineke/indent-blankline.nvim',
			opt = true,
			event = 'BufEnter',
			config = function() require('nv_blankline') end
		}
		-- Vista previa de MarkDown
		use {
			'iamcco/markdown-preview.nvim',
			config = "vim.call('mkdp#util#install')",
			opt = true,
			ft = {'markdown', 'vimwiki'}
		}
		-- Debugger
		use 'puremourning/vimspector'
		-- Ayuda con accesis directos
		use 'folke/which-key.nvim'
		-- Parser veloz
		use 'nvim-treesitter/nvim-treesitter'
		use 'nvim-treesitter/nvim-treesitter-textobjects'
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
		-- OneDark
		use {'norcalli/nvim-base16.lua'}
		-- Tabline
		use {'akinsho/nvim-bufferline.lua'}
		-- Snippets
		use {
			'SirVer/ultisnips',
			opt = true,
			cond = not CoC_enabled and isNodeAvailable
		}
		-- LSn
		use {
			'neovim/nvim-lspconfig',
			opt = true,
			cond = not CoC_enabled and isNodeAvailable
		}
		use {
			'hrsh7th/nvim-compe',
			opt = true,
			cond = not CoC_enabled and isNodeAvailable
		}
		use {
			'glepnir/lspsaga.nvim',
			opt = true,
			cond = not CoC_enabled and isNodeAvailable
		}
		use {
			'kabouzeid/nvim-lspinstall',
			opt = true,
			cond = not CoC_enabled and isNodeAvailable
		}
		use {
			'mfussenegger/nvim-jdtls',
			opt = true,
			cond = not CoC_enabled and isNodeAvailable
		}

		-- CoC
		use {
			'neoclide/coc.nvim',
			opt = true,
			cond = CoC_enabled and isNodeAvailable
		}
		-- TODO.txt
		use { 'vim-scripts/todo-txt.vim' }
	end
end)
