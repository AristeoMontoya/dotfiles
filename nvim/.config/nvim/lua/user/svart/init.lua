local svart = require("svart")

svart.configure({
	key_cancel = "<Esc>",       -- cancel search
	key_delete_char = "<BS>",   -- delete query char
	key_delete_word = "<C-W>",  -- delete query word
	key_delete_query = "<C-U>", -- delete whole query
	key_best_match = "<CR>",    -- jump to the best match
	key_next_match = "<C-N>",   -- select next match
	key_prev_match = "<C-P>",   -- select prev match

	label_atoms = "jfkdlsahgnuvrbytmiceoxwpqz", -- allowed label chars
	label_location = -1,                        -- label location relative to the match
	                                            -- positive: relative to the start of the match
	                                            -- 0 or negative: relative to the end of the match
	label_max_len = 2,                          -- max label length
	label_min_query_len = 1,                    -- min query length required to show labels
	label_hide_irrelevant = true,               -- hide irrelevant labels after start typing label to go to
	label_conflict_foresight = 3,               -- number of chars from the start of the match to discard from labels pool

	search_update_register = false, -- update search (/) register with last used query after accepting match
	search_wrap_around = true,     -- wrap around when navigating to next/prev match
	search_multi_window = true,    -- search in multiple windows

	ui_dim_content = false, -- dim buffer content during search
})
