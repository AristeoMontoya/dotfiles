require('globals')
require("which-key").setup {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true -- bindings for prefixed with g
		}
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+" -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
		padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = {min = 4, max = 25}, -- min and max height of the columns
		width = {min = 20, max = 50}, -- min and max width of the columns
		spacing = 3 -- spacing between columns
	},
	hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
	show_help = true -- show help message on the command line when the popup is visible
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false -- use `nowait` when creating keymaps
}

-- Set leader
V.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
V.g.mapleader = ' '

-- no hl
V.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
V.api.nvim_set_keymap('n', '<Leader>fe', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- telescope
V.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', {noremap = true, silent = true})

local mappings = {
	["h"] = {"No Highlight"},
	["c"] = {"Quick capture"},
	["<oc>"] = {"Open config"},
	["<rt>"] = {"Swap spaces for tabs"},
	b = {
		name = "+Buffer",
		k = "Kill current buffer"
	},
	g = {
		name = "git",
		s = 'Stage hunk',
		u = 'Undo stage hunk',
		r = 'Reset hunk',
		p = 'Preview hunk',
		d = 'Show diff'
	},
	f = {
		name = "+Find",
		b = "Buffer",
		B = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
		C = {"<cmd>Telescope git_commits<cr>", "Colorscheme"},
		d = "Definition",
		e = "Open file explorer",
		f = "Files",
		g = "Grep",
		h = "Help tags",
		n = "Notes"
	},
	d = {
		name = "+Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
	},
	l = {
		name = "+LSP",
		a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
		d = {"<cmd>TroubleToggle<cr>", "Document Diagnostics"},
		i = {"<cmd>LspInfo<cr>", "Info"},
		q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
		r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
		x = {"<cmd>cclose<cr>", "Close Quickfix"},
		s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
	},
	s = {
		name = "+Splits",
		h = "Horizontal split",
		v = "Vertical split",
		r = "Rotate splits",
		t = "Move split to tab",
	},
	t = {
		name = "+Tabs",
		k = "Kill current tab",
		n = "Open new tab"
	},
	w = {
		name = "+VimWiki",
		i = "Diary index",
		s = "Select Wiki",
		w = "Open Wiki index",
		t = "Open index in new tab",
		["<space>"] = {
			name = "+Diary",
			i = "Fill diary index",
			m = "Make tomorrow's note",
			t = "Make diary note in new tab",
			w = "Make today's diary note",
			y = "Make yesterday's note"
		}
	},
	v = {
		name = "+Spelling",
		s = "Verify spanish",
		e = "Verify english",
		n = "Disable spell checking"
	},
	S = {
		name = "+Session",
		s = {"<cmd>SessionSave<cr>", "Save Session"},
		l = {"<cmd>SessionLoad<cr>", "Load Session"}
	},
	o = "which_key_ignore",
	r = "which_key_ignore",
}

local wk = require("which-key")
wk.register(mappings, opts)
