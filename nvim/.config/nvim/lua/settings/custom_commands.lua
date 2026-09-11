--- Intended for commands that require some sort of cache
local state = {}

-- Neovim remembers 'relativenumber' per (window, buffer) pair, not just per
-- window, so restoring only the currently displayed buffer leaves other
-- buffers shown earlier in that window with a stale value. Reapplying it on
-- every buffer entry sidesteps that entirely.
local function apply_relativenumber(win)
	local presentation = state.presentation
	-- also bail on special windows (cmdline-window, popups, floats, quickfix,
	-- etc.), only touch normal editing windows
	if not presentation or vim.fn.win_gettype(win) ~= "" or vim.api.nvim_win_get_config(win).relative ~= "" then
		return
	end
	if presentation.enabled then
		vim.wo[win].relativenumber = false
	else
		vim.wo[win].relativenumber = presentation.original_relativenumber
	end
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("PresentationMode", { clear = true }),
	callback = function()
		apply_relativenumber(vim.api.nvim_get_current_win())
	end,
})

vim.api.nvim_create_user_command(
	"TogglePresentationMode",
	function()
		state.presentation = state.presentation or { original_relativenumber = vim.o.relativenumber }
		state.presentation.enabled = not state.presentation.enabled

		for _, win in ipairs(vim.api.nvim_list_wins()) do
			apply_relativenumber(win)
		end
	end,
	{ desc = "Enable presentation mode. Disable relative lines." }
)
