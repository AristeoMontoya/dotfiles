local is_tmux_session = vim.env.TERM_PROGRAM == "tmux" -- Tmux is its own clipboard provider which directly works.

if vim.env.SSH_TTY and not is_tmux_session then
	local function paste()
		return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
	end
	local osc52 = require("vim.ui.clipboard.osc52")
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = osc52.copy("+"),
			["*"] = osc52.copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
