return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	commit = require("settings.versions").codediff,
	opts = {
		explorer = {
			view_mode = "tree",
		},
	},
	config = function(_, opts)
		local codediff = require("codediff")
		codediff.setup(opts)

		-- Must run before other handlers, they can't navigate a codediff view
		require("utils.hunk_nav").register(function(direction)
			-- Returns false when there is no codediff session in the current tab
			return codediff[direction .. "_hunk"]()
		end, 100)
	end,
}
