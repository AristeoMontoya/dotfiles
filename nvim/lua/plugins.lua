require('globals')

V.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

function IsCocEnabled()
	return COC and HAS_NODE
end

function IsInsideVsCode()
	return IS_VSCODE
end

function ShouldUseLsp()
	return not COC and HAS_NODE
end

-- For auto install
local fn = V.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	-- Surround
	use {'tpope/vim-surround'}

	use {
		'asvetliakov/vim-easymotion',
		opt = true,
		cond = IsInsideVsCode
	}

	if not IsInsideVsCode() then
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
		use {
			'kyazdani42/nvim-tree.lua',
			config = function() require('nv_tree') end
		}
		-- Vimwiki
		use {
			'vimwiki/vimwiki',
			config = function() V.cmd('source ~/.config/nvim/vimscript/vimwiki.vim') end
		}
		-- Vista previa web
		use {'turbio/bracey.vim', run = 'npm install --prefix server'}
		-- Vista previa de colores
		use {
			'norcalli/nvim-colorizer.lua',
			config = function() require('nv_colorizer') end
		}

		-- Autocompletado
		-- use {'neoclide/coc.nvim', branch = 'release'}
		-- Autopares
		use 'jiangmiao/auto-pairs'
		-- Búsqueda difusa
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
			config = function() require('nv_telescope') end
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
		use {
			'puremourning/vimspector',
			config = function() V.cmd('source ~/.config/nvim/vimscript/vimspector.vim') end
		}
		-- Ayuda con accesis directos
		use {
			'folke/which-key.nvim',
			config = function() require('nv_whichkey') end
		}
		-- Parser veloz
		use {
			'nvim-treesitter/nvim-treesitter',
			config = function() require('nv_treesitter') end
		}
		use 'nvim-treesitter/nvim-treesitter-textobjects'
		-- Colores de TreeSitter
		use 'nvim-treesitter/playground'
		-- Integración con git
		use {
			'airblade/vim-gitgutter',
			config = function() V.cmd('source ~/.config/nvim/vimscript/gitgutter.vim') end
		}
		-- Comentarios rápidos
		use 'tpope/vim-commentary'
		-- Integración con comandos de git
		use 'tpope/vim-fugitive'
		-- Línea de status
		use {
			'hoob3rt/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons', opt = true},
			config = function() require('nv_lualine') end
		}
		-- OneDark
		use {'norcalli/nvim-base16.lua'}
		-- Tabline
		use {
			'akinsho/nvim-bufferline.lua',
			config = function() require('nv_bufferline') end
		}
		-- Snippets
		use {
			'SirVer/ultisnips',
			opt = true,
			cond = ShouldUseLsp,
			config = function() require('nv_ultisnips') end
		}
		-- LSP
		use {
			'neovim/nvim-lspconfig',
			opt = true,
			cond = ShouldUseLsp
		}
		use {
			'williamboman/nvim-lsp-installer',
			opt = true,
			cond = ShouldUseLsp,
			config = function() require('nv_lspinstall') end
		}
		use {
			'hrsh7th/nvim-cmp',
			opt = true,
			cond = ShouldUseLsp,
			config = function() require('nv_cmp') end
		}
		use { 'hrsh7th/cmp-nvim-lsp' }
		use { 'hrsh7th/cmp-buffer' }
		use { 'hrsh7th/cmp-path' }
		use { 'hrsh7th/cmp-cmdline' }
		use { "quangnguyen30192/cmp-nvim-ultisnips" }
		use {
			'mfussenegger/nvim-jdtls',
			opt = true,
			cond = ShouldUseLsp
		}

		-- CoC
		use {
			'neoclide/coc.nvim',
			opt = true,
			cond = IsCocEnabled,
			config = function() V.cmd('source ' .. CONFIG_PATH .. '/vimscript/coc.vim') end
		}

		if Packer_bootstrap then
			require('packer').sync()
		end
	end
end)
