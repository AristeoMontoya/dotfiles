return {
	dir = vim.env.VIMRUNTIME, -- built-in feature, no plugin to install
	name = "ui2",
	opts = {
		enable = true, -- Whether to enable or disable the UI.
		msg = { -- Options related to the message module.
			---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
			---or table mapping |ui-messages| kinds, triggers and IDs to a target.
			---Table keys are are matched as a Lua pattern to the message ID. 'default'
			---mapping applies to any omitted kind: { default = 'cmd', progress = 'msg' }.
			targets = "msg",
			cmd = { -- Options related to messages in the cmdline window.
				-- Maximum height (rows if >=1, or % of 'lines' if <1) of messages expanded
				-- beyond 'cmdheight'; 0.999 for full height.
				height = 0.5,
			},
			dialog = { -- Options related to dialog window.
				height = 0.5, -- Maximum height.
			},
			msg = { -- Options related to msg window.
				height = 0.5, -- Maximum height.
				timeout = 4000, -- Time a message is visible in the message window.
			},
			pager = { -- Options related to message window.
				height = 0.999, -- Maximum height.
			},
		},
	},
	config = function(_, opts)
		require("vim._core.ui2").enable(opts)
	end,
}
