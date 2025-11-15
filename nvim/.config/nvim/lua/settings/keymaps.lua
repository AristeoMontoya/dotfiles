-- Keymaps coonfiguration
-- Intended to work without any plugin installed.
-- Plugin related keymaps should be defined within
-- the plugin spec.
local map = vim.keymap.set

local function is_text_buffer(pressed_key)
	local buf_type = vim.api.nvim_get_option_value("buftype", { buf = vim.api.nvim_get_current_buf() })

	if buf_type == "nofile" or buf_type == "acwrite" or buf_type == "prompt" then
		return pressed_key
	end
end

-- General keymaps
map("n", " ", "<nop>", { noremap = true, silent = true, desc = "Disable space for normal mode" })
map("n", "<leader>h", ":noh<CR>", { noremap = true, silent = true, desc = "Remove buffer highlighting" })

-- Go to previous file
map("n", "<C-a>", ":e#<CR>", { noremap = true, silent = true, desc = "Return to previous file" })

-- Center buffer after next occurrence
map("n", "n", "nzz", { noremap = true, silent = true, desc = "Go to next occurrence" })
map("n", "N", "Nzz", { noremap = true, silent = true, desc = "Go to previous occurrence" })

-- Center buffer after page movement
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Page down" })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Page up" })

-- Center after joining lines
map("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Join lines" })

-- Copy to the end of line
map("n", "Y", "y$", { noremap = true, silent = true, desc = "Copy until end of line" })

-- Split movements
-- Need to replace this keymaps with vanilla nvim ones
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")

-- -- Split resize
map("n", "<C-A-h>", "<cmd>resize -3<CR>")
map("n", "<C-A-j>", "<cmd>vertical resize -3<CR>")
map("n", "<C-A-k>", "<cmd>resize 3<CR>")
map("n", "<C-A-l>", "<cmd>vertical resize 3<CR>")

-- Split creation
map("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true, desc = "Horizontal split" })
map("n", "<leader>sv", ":vs<CR>", { noremap = true, silent = true, desc = "Vertical split" })

-- Split rotation
map("n", "<leader>sr", "<C-W>R", { noremap = true, silent = true, desc = "Rotate splits" })

-- Split to tab
map("n", "<leader>st", "<C-W>T", { noremap = true, silent = true, desc = "Split into tabs" })

-- Save buffer
map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save buffer" })

-- Close buffer
map("n", "<leader>bk", ":bd<CR>", { noremap = false, silent = true, desc = "Close buffer" })

-- Alternate buffer
map("n", "<tab>", ":bnext<CR>", { noremap = false, silent = true, desc = "Go to next buffer" })
map("n", "<S-tab>", ":bprevious<CR>", { noremap = false, silent = true, desc = "Go to previous buffer" })

-- Jump to previous buffer
map("n", "<C-a>", "<C-^>", { noremap = true, silent = true, desc = "Go to last buffer" })

-- Disable arrow keys
map("n", "<left>", "<nop>", {})
map("n", "<right>", "<nop>", {})
map("n", "<up>", "<nop>", {})
map("n", "<down>", "<nop>", {})

-- Disable arrow keys for insert mode
-- except for prompts
-- There's probably a better way to do this but I'm feeling sleepy at the moment
map("i", "<left>", function()
	return is_text_buffer("<left>")
end, { expr = true })
map("i", "<right>", function()
	return is_text_buffer("<right>")
end, { expr = true })
map("i", "<up>", function()
	return is_text_buffer("<up>")
end, { expr = true })
map("i", "<down>", function()
	return is_text_buffer("<down>")
end, { expr = true })

-- Keep visual mode during indenting
map("v", "<", "<gv", { noremap = true, silent = true, desc = "Decrease indentations" })
map("v", ">", ">gv", { noremap = true, silent = true, desc = "Increase indentation" })

-- Spells
map(
	"n",
	"<leader>vs",
	":setlocal spell spelllang=es_mx<CR>",
	{ noremap = true, desc = "Enable spellcheck for spanish" }
)
map(
	"n",
	"<leader>ve",
	":setlocal spell spelllang=en_us<CR>",
	{ noremap = true, desc = "Enable spellcheck for english" }
)
map("n", "<leader>vn", ":setlocal nospell<CR>", { noremap = true, silent = true, desc = "Disable spellcheck" })
