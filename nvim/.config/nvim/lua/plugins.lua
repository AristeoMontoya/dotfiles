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
			'rlane/pounce.nvim',
			config = function() require('nv_pounce') end
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
		-- Vista previa de colores
		use {
			'norcalli/nvim-colorizer.lua',
			config = function() require('nv_colorizer') end
		}
		-- Autopares
		use {
			'windwp/nvim-autopairs',
			config = function() require('nv_autopairs') end
		}
		-- Búsqueda difusa
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
			config = function() require('nv_telescope') end
		}
		use {
			'nvim-telescope/telescope-ui-select.nvim',
		}
		-- Marcado de identación con espacios
		use {
			'lukas-reineke/indent-blankline.nvim',
			opt = true,
			event = 'BufEnter',
			config = function() require('nv_blankline') end
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
		use { 'nvim-treesitter/nvim-treesitter-textobjects'}
		-- Colores de TreeSitter
		use { 'nvim-treesitter/playground'}
		use { 'p00f/nvim-ts-rainbow'}
		-- Integración con git
		use {
			'lewis6991/gitsigns.nvim',
			config = function() require('nv_gitsigns') end,
			requires = {
				'nvim-lua/plenary.nvim'
			},
		}
		-- Comentarios rápidos
		use { 'numToStr/Comment.nvim',
			config = function() require('nv_comment') end
		}
		-- Línea de status
		use {
			'hoob3rt/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons', opt = true},
			config = function() require('nv_lualine') end
		}
		-- OneDark
		use { 'norcalli/nvim-base16.lua' }
		-- Tabline
		use {
			'akinsho/nvim-bufferline.lua',
			config = function() require('nv_bufferline') end
		}
		-- LSP
		use {
			'williamboman/nvim-lsp-installer',
			opt = true,
			cond = ShouldUseLsp,
			config = function() require('nv_lspinstall') end
		}
		use {
			'neovim/nvim-lspconfig',
		}
		-- Snippets and autocomplete
		use {
			'hrsh7th/nvim-cmp',
			opt = true,
			cond = ShouldUseLsp,
			-- Snippet engine
			{
				'L3MON4D3/LuaSnip',
				opt = true,
				cond = ShouldUseLsp,
				config = function()
					require('nv_luasnip')
					require('nv_cmp')
				end,
			}
		}
		-- Autocomplete
		use { 'hrsh7th/cmp-nvim-lsp' }
		use { 'hrsh7th/cmp-buffer' }
		use { 'hrsh7th/cmp-path' }
		use { 'hrsh7th/cmp-cmdline' }
		use { 'hrsh7th/cmp-omni' }
		use { 'saadparwaiz1/cmp_luasnip' }
		use { 'mfussenegger/nvim-jdtls' }

		-- Pretty diagnostics
		use { 'folke/trouble.nvim' }

		-- Document highlight
		use {
			'RRethy/vim-illuminate',
			config = function() require('nv_illuminate') end,
		}
		-- DAP
		use { 'mfussenegger/nvim-dap' }
		use { 'theHamsta/nvim-dap-virtual-text' }
		use {
			'rcarriga/nvim-dap-ui',
			config = function() require('nv_dapui') end,
		}
		use { 'Pocco81/DAPInstall.nvim' }

		-- Better Terminal
		use {
			'akinsho/toggleterm.nvim',
			config = function () require('nv_toggleterm') end
		}

		if Packer_bootstrap then
			require('packer').sync()
		end
	end
end)