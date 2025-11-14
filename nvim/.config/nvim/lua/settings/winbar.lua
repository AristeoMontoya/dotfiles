-- Inspired by https://github.com/gmr458/nvim/blob/8f444ada0d715ae7d24114b8c10d9b471c9a2306/lua/gmr/core/winbar.lua
local winbar_excluded = {
	"help",
	"minifiles",
	"snacks_picker_input",
	"snacks_picker_preview",
	"snacks_picker_list",
	"Trouble",
	"trouble",
	"dap-float",
	"dap-repl",
	"commandline",
}

local function is_excluded()
	if vim.tbl_contains(winbar_excluded, vim.bo.filetype) then
		vim.opt_local.winbar = nil
		return true
	end

	return false
end

local function set_local_winbar()
	if is_excluded() then
		return
	end
	vim.opt_local.winbar = "%=%m %f"
end

vim.api.nvim_create_autocmd({
	"CursorMoved",
	"CursorHold",
	"BufWinEnter",
	"BufFilePost",
	"InsertEnter",
	"BufWritePost",
	"TabClosed",
}, {
	group = vim.api.nvim_create_augroup("gmr_winbar", { clear = true }),
	callback = function()
		local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
		if not status_ok then
			-- set_local_winbar()
		end
	end,
})
