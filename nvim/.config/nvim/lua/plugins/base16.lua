return {
	"norcalli/nvim-base16.lua",
	commit = require("settings.versions").nvim_base16,
	config = function()
		local cmd = V.cmd
		local status, base16 = pcall(require, "base16")
		if status then
			base16(base16.themes["onedark"], true)
		end

		-- Neovim
		cmd("hi LineNr guibg=NONE")
		cmd("hi SignColumn guibg=NONE")
		cmd("hi VertSplit guibg=NONE guifg=#3e4451")
		cmd("hi CursorLine guibg=#2c323c")
		cmd("hi CursorLineNr gui=None guifg=#abb2bf guibg=#2c323c")
		cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
		cmd("hi DiffChange guifg =#3A3E44 guibg = none")
		cmd("hi DiffModified guifg = #81A1C1 guibg = none")
		cmd("hi EndOfBuffer guifg=#282c34")
		cmd("hi Delimiter None")
		cmd("hi Underlined guifg=None")
		cmd("hi Error guifg=None guibg=None")
		cmd("hi vimTSStringSpecial guifg=#c678dd guibg=None")
		cmd("highlight WinBar guibg=#454C59")
		cmd("highlight WinBarNC guibg=#454C59")
		cmd("highlight NormalFloat guibg=#1f2228")

		-- GitGutter
		cmd("hi GitGutterAdd guibg=None guifg=#98c379")
		cmd("hi GitGutterChange guibg=None guifg=#61afef")
		cmd("hi GitGutterDelete guibg=None guifg=#e06c75")
		cmd("hi GitGutterChangeDelete guibg=None guifg=#c678dd")
		cmd("hi GitGutterAddLine guibg=None guifg=#98c379")
		cmd("hi GitGutterChangeLine guibg=None guifg=#61afef")
		cmd("hi GitGutterDeleteLine guibg=None guifg=#e06c75")
		cmd("hi GitGutterChangeDeleteLine guibg=None guifg=#c678dd")

		-- TreeSitter
		cmd("hi tskeywordoperator guifg=#d291e4")
		cmd("hi tstypebuiltin guifg=#c678dd")
		cmd("hi tsparameter guifg=#56b6c2")
		cmd("hi tstitle guifg=#e5c07b")
		cmd("hi tsinclude guifg=#d291e4")
		cmd("hi tsrepeat guifg=#d291e4")
		cmd("hi tserror guibg=None guifg=#e06c75")
		cmd("hi tstag guibg=None guifg=#e06c75")
		cmd("hi htmltstagattribute guibg=None guifg=#e5c07b")
		cmd("hi tscharacter guifg=#98c379")
		cmd("hi tsmethod gui=bold guifg=#61afef")

		-- CoC
		cmd("hi pmenusel guibg=#98c379")

		-- Lualine
		cmd("hi lualine_y_diff_added_normal guifg=#98c379")
		cmd("hi lualine_y_diff_added_inactive guifg=#98c379")

		cmd("hi lualine_y_diff_modified_normal guifg=#56b6c2")
		cmd("hi lualine_y_diff_modified_inactive guifg=#56b6c2")

		cmd("hi lualine_y_diff_removed_normal guifg=#e06c75")
		cmd("hi lualine_y_diff_removed_inactive guifg=#e06c75")

		-- NvimTree
		cmd("hi NvimTreeNormal guibg=#1f2228")
		cmd("hi NvimTreeNormalFloat guibg=#1e2127")
		cmd("hi NvimTreeCursorLine guibg=#282c34")
		cmd("hi NvimTreeRootFolder guifg=#C678DD")
		cmd("hi NvimTreeExecFile guifg=#98c379")
		cmd("hi NvimTreeImageFile guifg=#C678DD")
		cmd("hi NvimTreeSpecialFile guifg=#56B6C2")
		cmd("hi NvimTreeOpenedFile gui=bold guifg=#CFD7E6")

		-- LSP
		-- cmd("hi LspDiagnosticsError guibg=#000000")
		-- cmd("hi LspDiagnosticsWarning guibg=#000000")
		-- cmd("hi LspDiagnosticsInformation guibg=#000000")
		-- cmd("hi LspDiagnosticsHint guibg=#000000")

		-- Illuminate
		cmd("hi illuminatedWord guibg=#313640")
		cmd("hi illuminatedWordRead guibg=#313640 gui=none")
		cmd("hi illuminatedWordWrite guibg=#313640 gui=none")
		cmd("hi illuminatedWordText guibg=#313640 gui=none")

		-- Íconos
		cmd("hi NvimTreeLicenseIcon guibg=none")
		cmd("hi NvimTreeYamlIcon guibg=none")
		cmd("hi NvimTreeTomlIcon guibg=none")
		cmd("hi NvimTreeFolderIcon guifg=#61AFEF")

		-- Colores de git
		cmd("hi NvimTreeGitignoreIcon guifg=#454C59")
		cmd("hi NvimTreeGitDirty guifg=#E06C75")
		cmd("hi NvimTreeGitStaged guifg=#98c379")

		cmd("hi NvimTreeGitRenamed guifg=#C678DD")
		cmd("hi NvimTreeGitNew guifg=#C678DD")
		cmd("hi NvimTreeGitDeleted guifg=#E06C75")

		-- lsp
		cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=#61AFEF")
		cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#61AFEF")
		cmd("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
		cmd("highlight DiagnosticError guifg=#E06C75")
		cmd("highlight DiagnosticWarn guifg=#e5c07b")

		-- Flash
		cmd("highlight FlashMatch guibg=#66D9E8 guifg=#2c323c")
		cmd("highlight FlashLabel guibg=#C678DD guifg=#2c323c")

		-- dapui
		-- NC variants are used when not in focus
		cmd("highlight DapUIStopNC guibg=none")
		cmd("highlight DapUINormalNC guibg=none")
		cmd("highlight DapUIFloatNormal guibg=none")
		cmd("highlight DapUIUnavailableNC guifg=#424242 guibg=none")
		cmd("highlight DapUIUnavailable guifg=#424242 guibg=none")
		cmd("highlight DapUIPlayPauseNC guifg=#a9ff68 guibg=#454C59")
		cmd("highlight DapUIPlayPause guifg=#a9ff68 guibg=#454C59")
		cmd("highlight DapUIRestartNC guifg=#a9ff68 guibg=#454C59")
		cmd("highlight DapUIRestart guifg=#a9ff68 guibg=#454C59")
		cmd("highlight DapUIStopNC guifg=#f70067 guibg=#454C59")
		cmd("highlight DapUIStop guifg=#f70067 guibg=#454C59")
		cmd("highlight DapUIStepOverNC guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapUIStepOver guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapUIStepIntoNC guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapUIStepInto guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapUIStepBackNC guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapUIStepBack guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapUIStepOutNC guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapUIStepOut guifg=#00f1f5 guibg=#454C59")
		cmd("highlight DapStoppedLine guibg=#424242")

		-- whichkey
		cmd("highlight WhichKeySeparator guifg=#61AFEF")
	end,
}
