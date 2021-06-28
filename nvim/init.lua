require('globals')
-- Necesarias en caso de usar VSCode
V.cmd('source ~/.config/nvim/vimscript/generalvscode.vim')
require('plugins')

if VSCODE ~= 1 then
	V.cmd('source ~/.config/nvim/vimscript/general.vim')
	require('nv_colorizer')
	require('nv_treesitter')
	require('nv_telescope')
	require('nv_bufferline')
	require('nv_lualine')
	require('nv_compe')
	require('nv_lspinstall')
	require('nv_ultisnips')
	require('nv_whichkey')
	-- require('nv_orgmode')
	V.cmd('source ~/.config/nvim/vimscript/nvim-tree.vim')
	V.cmd('source ~/.config/nvim/vimscript/indentLine.vim')
	-- V.cmd('source ~/.config/nvim/vimscript/whichkey.vim')
	V.cmd('source ~/.config/nvim/vimscript/gitgutter.vim')
	V.cmd('source ~/.config/nvim/vimscript/vimspector.vim')
	V.cmd('source ~/.config/nvim/vimscript/vimwiki.vim')
	V.cmd('source ~/.config/nvim/vimscript/keymaps.vim')
	V.cmd('source ~/.config/nvim/vimscript/autocommands.vim')
	require('nv_base16')

	-- LSP
	require('lsp')
	require('lsp.python')
	require('lsp.bash')
	require('lsp.java')
	require('lsp.js')
	require('lsp.lua-ls')
else
	V.cmd('source ~/.config/nvim/vimscript/vscodemaps.vim')
end
