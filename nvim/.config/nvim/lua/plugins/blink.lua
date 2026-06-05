local versions = require("settings.versions")
return {
	"saghen/blink.cmp",
	commit = versions.blink,
	dependencies = {
		{ "L3MON4D3/LuaSnip", commit = versions.luasnip },
		{ "folke/lazydev.nvim", commit = versions.lazydev, ft = "lua" },
		-- Native blink DAP source (replaces rcarriga/cmp-dap)
		-- https://github.com/mayromr/blink-cmp-dap
		-- { "mayromr/blink-cmp-dap", commit = versions.cmp_dap },
		{ "saghen/blink.compat", lazy = true, commit = versions.blink_compat, config = true },
		{ "Kaiser-Yang/blink-cmp-git", commit = versions.blink_git },
		{ "rcarriga/cmp-dap", commit = versions.cmp_dap },
		{ "antosha417/nvim-lsp-file-operations", commit = versions.nvim_lsp_file_operations, config = true },
		{ "rmagatti/goto-preview", config = true, commit = versions.goto_preview },
	},
	config = function()
		-- Mirror the highlight overrides from the old cmp setup.
		-- blink uses BlinkCmpLabelMatch / BlinkCmpLabelDeprecated instead of
		-- the nvim-cmp CmpItemAbbr* groups.
		local hl_ok, set_highlights = pcall(require, "utils.register_highlights")
		if hl_ok then
			set_highlights({
				{ group = "BlinkCmpLabelMatch", value = { bg = nil, fg = "#61AFEF", force = true } },
				{
					group = "BlinkCmpLabelDeprecated",
					value = { bg = nil, fg = "#808080", strikethrough = true, force = true },
				},
			})
		end

		require("blink.cmp").setup({
			-- ── Enabled ────────────────────────────────────────────────────────
			-- Replaces the cmp `enabled` guard.
			-- Returning "force" tells blink to ignore its own default conditions
			-- (buftype ~= "prompt") so DAP UIs still get completions.
			enabled = function()
				local ft = vim.bo.filetype
				if ft == "dap-repl" or ft == "dapui_watches" then
					return "force"
				end
				return vim.bo.buftype ~= "prompt"
			end,

			snippets = { preset = "luasnip" },

			-- <Tab>  chain: accept selected → jump snippet forward → open menu → fallback
			-- <S-Tab> chain: select prev   → jump snippet back → fallback
			-- This matches the three-branch logic in your old <Tab> mapping.
			keymap = {
				preset = "none",
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-Space>"] = { "show", "fallback" },
				["<C-x><C-o>"] = { "show", "fallback" },
				["<C-e>"] = { "cancel", "fallback" },
				-- TODO: Make this readable
				["<Tab>"] = {
					function(cmp)
						if cmp.is_visible() then
							return cmp.select_and_accept()
						end
					end,
					function()
						local ls = require("luasnip")
						if ls.expand_or_locally_jumpable() then
							vim.schedule(function()
								ls.expand_or_jump()
							end)
							return true
						end
					end,
					function(cmp)
						local line, col = unpack(vim.api.nvim_win_get_cursor(0))
						local before = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
						if col ~= 0 and before:match("%s") == nil then
							return cmp.show()
						end
					end,
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						if cmp.is_visible() then
							return cmp.select_prev()
						end
					end,
					function()
						local ls = require("luasnip")
						if ls.jumpable(-1) then
							vim.schedule(function()
								ls.jump(-1)
							end)
							return true
						end
					end,
					"fallback",
				},
			},
			cmdline = {
				enabled = true,
				keymap = {
					-- 	preset = "none",
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<Tab>"] = { "select_and_accept", "fallback" },
				},
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},

			sources = {
				-- Default order: LSP first, then snippets, path, lazydev.
				-- Buffer is intentionally left out of default (commented in original).
				default = { "lsp", "snippets", "path", "lazydev" },

				per_filetype = {
					-- cmp_git has no blink port yet; buffer is the fallback used in
					-- the original anyway.
					gitcommit = { "git" },
					["dap-repl"] = { "dap" },
					dapui_watches = { "dap" },
				},

				providers = {
					-- lazydev: score_offset = 100 replicates group_index = 0 from cmp
					-- (always surfaces above LSP items for Lua files).
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					-- in providers
					dap = {
						name = "dap",
						module = "blink.compat.source",
						async = true,
						opts = { name = "dap" },
					},
					git = {
						module = "blink-cmp-git",
						name = "git",
					},
				},
			},

			completion = {
				ghost_text = {
					enabled = true,
				},
				list = {
					selection = {
						-- First item is highlighted so <Tab> can immediately accept.
						-- This matches cmp's confirm({ select = true }) behaviour.
						preselect = true,
						auto_insert = false,
					},
				},

				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
					},
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
			},
			signature = {
				window = {
					border = "rounded",
				},
			},

			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "",
					Method = "",
					Function = "󰊕",
					Constructor = "",
					Field = "",
					Variable = "󰀫",
					Class = "",
					Interface = "",
					Module = "",
					Property = "",
					Unit = "",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "󰆐",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "",
					Event = "",
					Operator = "󰿈",
					TypeParameter = "󰅲",
				},
			},
		})

		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})
	end,
}
