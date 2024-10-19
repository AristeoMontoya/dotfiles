local map = V.api.nvim_set_keymap

local setmap = V.keymap.set

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
setmap("n", "<A-h>", require("smart-splits").move_cursor_left)
setmap("n", "<A-j>", require("smart-splits").move_cursor_down)
setmap("n", "<A-k>", require("smart-splits").move_cursor_up)
setmap("n", "<A-l>", require("smart-splits").move_cursor_right)

-- Split resize
setmap("n", "<C-A-h>", require("smart-splits").resize_left)
setmap("n", "<C-A-j>", require("smart-splits").resize_down)
setmap("n", "<C-A-k>", require("smart-splits").resize_up)
setmap("n", "<C-A-l>", require("smart-splits").resize_right)

-- moving between splits
-- swapping buffers between windows
setmap("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
setmap("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
setmap("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
setmap("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

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
map("n", "<leader>bk", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })

-- Alternate buffer
map("n", "<tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Go to next buffer" })
map("n", "<S-tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Go to previous buffer" })

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
setmap("i", "<left>", function()
	return is_text_buffer("<left>")
end, { expr = true })
setmap("i", "<right>", function()
	return is_text_buffer("<right>")
end, { expr = true })
setmap("i", "<up>", function()
	return is_text_buffer("<up>")
end, { expr = true })
setmap("i", "<down>", function()
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

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Find grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true, desc = "Find buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true, desc = "Find help" })

-- NvimTree
map("n", "<leader>fe", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Open file tree" })

-- Trouble
map("n", "<leader>ld", ":TroubleToggle<CR>", { noremap = true, silent = true, desc = "Open diagnostics" })

-- Svart
map("n", "s", ":Svart<CR>", { noremap = true, silent = true, desc = "Jump to search" })
map("n", "S", ":SvartRegex<CR>", { noremap = true, silent = true, desc = "Jump to RegEx" })
map("n", "gs", ":SvartRepeat<CR>", { noremap = true, silent = true, desc = "Repeat last jump" })

-- Luasnip choice nodes
map("i", "<C-n>", "<Plug>luasnip-next-choice", { noremap = true, silent = true, desc = "Go to next Luasnip node" })
map("s", "<C-n>", "<Plug>luasnip-next-choice", { noremap = true, silent = true, desc = "Go to next Luasnip node" })
map("i", "<C-p>", "<Plug>luasnip-prev-choice", { noremap = true, silent = true, desc = "Go to last Luasnip node" })
map("s", "<C-p>", "<Plug>luasnip-prev-choice", { noremap = true, silent = true, desc = "Go to last Luasnip node" })
