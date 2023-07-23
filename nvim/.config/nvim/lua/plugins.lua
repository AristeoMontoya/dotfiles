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
			'https://gitlab.com/madyanov/svart.nvim',
			as = 'svart.nvim',
			config = function () require('user/svart') end
		}

		-- Tmux integration
		use {
			'numToStr/Navigator.nvim',
			config = function()
				require('Navigator').setup({
					disable_on_zoom = true
				})
			end
		}
		-- Packer can manage itself
		use {'wbthomason/packer.nvim'}
		-- Explorador de archivos
		use {
			'kyazdani42/nvim-tree.lua',
			requires = {'kyazdani42/nvim-web-devicons'},
			config = function() require('user/tree') end,
		}
		-- Vimwiki
		use {
			'vimwiki/vimwiki',
			config = function() V.cmd('source ~/.config/nvim/vimscript/vimwiki.vim') end
		}
		-- Vista previa de colores
		use {
			'norcalli/nvim-colorizer.lua',
			config = function() require('user/colorizer') end
		}
		-- Autopares
		use {
			'windwp/nvim-autopairs',
			config = function() require('user/autopairs') end
		}
		-- Búsqueda difusa
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
			config = function() require('user/telescope') end
		}
		use {
			'nvim-telescope/telescope-ui-select.nvim',
		}
		-- Marcado de identación con espacios
		use {
			'lukas-reineke/indent-blankline.nvim',
			opt = true,
			event = 'BufEnter',
			config = function() require('user/blankline') end
		}
		-- Ayuda con accesis directos
		use {
			'folke/which-key.nvim',
			config = function() require('user.whichkey') end
		}
		-- Parser veloz
		use {
			'nvim-treesitter/nvim-treesitter',
			config = function() require('user/treesitter') end
		}
		use { 'nvim-treesitter/nvim-treesitter-textobjects'}
		-- Colores de TreeSitter
		use { 'nvim-treesitter/playground'}
		use { 'p00f/nvim-ts-rainbow'}
		-- Integración con git
		use {
			'lewis6991/gitsigns.nvim',
			config = function() require('user/gitsigns') end,
			requires = {
				'nvim-lua/plenary.nvim'
			},
		}
		-- Comentarios rápidos
		use { 'numToStr/Comment.nvim',
			config = function() require('user.comment') end
		}
		-- Línea de status
		use {
			'hoob3rt/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons'},
			config = function() require('user/lualine') end
		}
		-- OneDark
		use { 'norcalli/nvim-base16.lua' }
		-- Tabline
		use {
			'akinsho/nvim-bufferline.lua',
			config = function() require('user/bufferline') end
		}
		-- LSP
		use {
			'williamboman/mason.nvim'
		}

		use {'williamboman/mason-lspconfig.nvim'}
		use {'jay-babu/mason-null-ls.nvim'}

		use {
			'neovim/nvim-lspconfig',
			config = function() require('user/lspconfig') end
		}

		-- pretty LSP
		use {
			'nvimdev/lspsaga.nvim',
			after = 'nvim-lspconfig',
			config = function()
				require('user.lspsaga')
			end
		}

		-- Formating
		use {
			'jose-elias-alvarez/null-ls.nvim',
			config = function() require("user/nullls") end
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
					require('user/luasnip')
					require('user/cmp')
				end,
			}
		}
		-- Autocomplete
		use { 'hrsh7th/cmp-nvim-lsp' }
		use { 'hrsh7th/cmp-buffer' }
		use { 'hrsh7th/cmp-path' }
		use { 'hrsh7th/cmp-cmdline' }
		use { 'hrsh7th/cmp-omni' }
		use { 'rcarriga/cmp-dap' }
		use { 'saadparwaiz1/cmp_luasnip' }
		use { 'mfussenegger/nvim-jdtls' }

		-- Pretty diagnostics
		use {
			'folke/trouble.nvim',
			config = function ()
				require('user.trouble')
			end
		}

		-- Document highlight
		use {
			'RRethy/vim-illuminate',
			config = function() require('user/illuminate') end,
		}
		-- DAP
		use { 'mfussenegger/nvim-dap' }
		use { 'theHamsta/nvim-dap-virtual-text' }
		use {
			'rcarriga/nvim-dap-ui',
			config = function() require('user/dapui') end,
		}
		use { "jayp0521/mason-nvim-dap.nvim" }

		-- Better Terminal
		use {
			'akinsho/toggleterm.nvim',
			config = function () require('user/toggleterm') end
		}

		if Packer_bootstrap then
			require('packer').sync()
		end
	end
end)
