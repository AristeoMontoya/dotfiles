return {
	"norcalli/nvim-base16.lua",
	commit = require("settings.versions").nvim_base16,
	config = function()
		local status, base16 = pcall(require, "base16")
		if status then
			base16(base16.themes["onedark"], true)
		end

		local hl_status, set_highlights = pcall(require, "utils.register_highlights")
		if not hl_status then
			return
		end

		set_highlights({
			-- neovim
			{ group = "LineNr", value = { bg = nil } },
			{ group = "SignColumn", value = { bg = nil } },
			{ group = "VertSplit", value = { bg = nil, fg = "#3e4451" } },
			{ group = "CursorLine", value = { bg = "#2c323c" } },
			{ group = "CursorLineNr", value = { fg = "#abb2bf", bg = "#2c323c" } },
			{ group = "DiffAdd", value = { fg = "#81A1C1", bg = nil } },
			{ group = "DiffChange", value = { fg = "#3A3E44", bg = nil } },
			{ group = "DiffModified", value = { fg = "#81A1C1", bg = nil } },
			{ group = "EndOfBuffer", value = { fg = "#282c34" } },
			{ group = "Delimiter", value = {} },
			{ group = "Underlined", value = { fg = nil } },
			{ group = "Error", value = { fg = nil, bg = nil } },
			{ group = "vimTSStringSpecial", value = { fg = "#c678dd", bg = nil } },
			{ group = "WinBar", value = { bg = "#454C59" } },
			{ group = "WinBarNC", value = { bg = "#454C59" } },
			{ group = "NormalFloat", value = { bg = "#1f2228" } },
			{ group = "PmenuSel", value = { fg = "#282C34", bg = "#98C379" } },
			-- search
			{ group = "Search", value = { bg = "#424242" } },
		})
	end,
}
