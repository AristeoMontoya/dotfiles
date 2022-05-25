local M = {}

function M.find_captures()
	require('telescope.builtin').live_grep {
		vimgrep_arguments = {
			'rg',
			'-g=!capturas.md',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_title = "~ capturas ~",
		shorten_path = false,
		cwd = "~/notas/capturas",
	}
end

function M.find_definition()
	require('telescope.builtin').live_grep {
		vimgrep_arguments = {
			'rg',
			'-g=[G|g]losario.md',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_title = "~ Definiciones ~",
		shorten_path = false,
		cwd = "~/notas",
	}
end

function M.find_nvim_source()
	require('telescope.builtin').find_files {
		prompt_title = "~ nvim ~",
		shorten_path = false,
		cwd = "~/build/neovim/",
		width = .25,
		layout_strategy = 'horizontal',
		layout_config = {
			preview_width = 0.65,
		},
	}
end

function M.find_notes()
	require('telescope.builtin').find_files {
		prompt_title = "~ nvim ~",
		shorten_path = false,
		cwd = "~/notas",
		width = .25,
		layout_strategy = 'horizontal',
		layout_config = {
			preview_width = 0.65,
		},
	}
	return true
end

function M.edit_zsh()
	require('telescope.builtin').find_files {
		shorten_path = false,
		cwd = "~/.config/zsh/",
		prompt = "~ dotfiles ~",
		layout_strategy = 'horizontal',
		layout_config = {
			preview_width = 0.55,
		},
	}
end

function M.fd()
	require('telescope.builtin').fd()
end

function M.builtin()
	require('telescope.builtin').builtin()
end

function M.live_grep()
	require('telescope').extensions.fzf_writer.staged_grep {
		shorten_path = true,
		previewer = false,
		fzf_separator = "|>",
	}
end

function M.oldfiles()
	if true then require('telescope').extensions.frecency.frecency() end
	if pcall(require('telescope').load_extension, 'frecency') then
	else
		require('telescope.builtin').oldfiles { layout_strategy = 'vertical' }
	end
end

function M.my_plugins()
	require('telescope.builtin').find_files {
		cwd = '~/plugins/',
	}
end

function M.buffers()
	require('telescope.builtin').buffers {
		shorten_path = false,
	}
end

function M.help_tags()
	require('telescope.builtin').help_tags {
		show_version = true,
	}
end

function M.search_all_files()
	require('telescope.builtin').find_files {
		find_command = { 'rg', '--no-ignore', '--files', },
	}
end

return setmetatable({}, {
	__index = function(_, k)
		if M[k] then
			return M[k]
		else
			return require('telescope.builtin')[k]
		end
	end
})
