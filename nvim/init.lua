require('globals')
-- Necesarias en caso de usar VSCode
V.cmd('source ~/.config/nvim/vimscript/generalvscode.vim')
require('plugins')

-- Cargan cuando no está VSCode
if VSCODE ~= 1 then
	V.cmd('source ~/.config/nvim/vimscript/general.vim')
	require('nv_colorizer')
	require('nv_treesitter')
	require('nv_telescope')
	require('nv_bufferline')
	require('nv_lualine')
	require('nv_whichkey')
	require('nv_orgmode')
	require('nv_blankline')
	if COC then
		V.cmd('source ~/.config/nvim/vimscript/coc.vim')
	else
		V.cmd('source ~/.config/nvim/vimscript/lsp_keymaps.vim')
		-- LSP
		require('lsp')
		require('lsp.python')
		require('lsp.bash')
		require('lsp.java')
		require('lsp.js')
		require('lsp.lua-ls')
		require('lsp.go')
		-- require('lsp.efm')
		require('lsp.html')
		require('lsp.emmet')
		require('lsp.vue')
		-- Autocompletado y demás
		require('nv_compe')
		require('nv_lspinstall')
		require('nv_ultisnips')
	end
	V.cmd('source ~/.config/nvim/vimscript/nvim-tree.vim')
	V.cmd('source ~/.config/nvim/vimscript/gitgutter.vim')
	V.cmd('source ~/.config/nvim/vimscript/vimspector.vim')
	V.cmd('source ~/.config/nvim/vimscript/vimwiki.vim')
	V.cmd('source ~/.config/nvim/vimscript/keymaps.vim')
	V.cmd('source ~/.config/nvim/vimscript/autocommands.vim')
	require('nv_base16')

else
	V.cmd('source ~/.config/nvim/vimscript/vscodemaps.vim')
end
