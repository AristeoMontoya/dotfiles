--- Intended for commands that require some sort of cache
local state = {}

vim.api.nvim_create_user_command(
	"TogglePresentationMode",
	function()
		local presentation = state.presentation or {}

		if presentation.enabled then
			presentation.enabled = false
			vim.opt.relativenumber = presentation.original_relativenumber
			return
		end

		presentation.original_relativenumber = vim.opt.relativenumber
		presentation.enabled = true

		vim.opt.relativenumber = false

		state.presentation = presentation
	end,
	{ desc = "Enable presentation mode. Disable relative lines." }
)
