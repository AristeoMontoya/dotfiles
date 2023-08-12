require('globals')
-- Necesarias en caso de usar VSCode
require('generalvscode')
require('plugins')

if not IS_VSCODE then
	V.cmd('source ~/.config/nvim/vimscript/general.vim')
	V.cmd('source ~/.config/nvim/vimscript/lsp_keymaps.vim')

	-- LSP
	require('lsp')
	V.cmd('source ~/.config/nvim/vimscript/autocommands.vim')
	require('settings.keymaps')
	require('settings.signcolumn')
	require('user.dap')
	require('user.base16')
else
	V.cmd('source ~/.config/nvim/vimscript/vscodemaps.vim')
end
