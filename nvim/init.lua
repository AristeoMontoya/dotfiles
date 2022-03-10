require('globals')
-- Necesarias en caso de usar VSCode
V.cmd('source ~/.config/nvim/vimscript/generalvscode.vim')
require('plugins')

if not IS_VSCODE then
	V.cmd('source ~/.config/nvim/vimscript/general.vim')
	if not COC then
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
	end
	V.cmd('source ~/.config/nvim/vimscript/gitgutter.vim')
	V.cmd('source ~/.config/nvim/vimscript/vimspector.vim')
	V.cmd('source ~/.config/nvim/vimscript/vimwiki.vim')
	V.cmd('source ~/.config/nvim/vimscript/keymaps.vim')
	V.cmd('source ~/.config/nvim/vimscript/autocommands.vim')
	require('nv_base16')

else
	V.cmd('source ~/.config/nvim/vimscript/vscodemaps.vim')
end
