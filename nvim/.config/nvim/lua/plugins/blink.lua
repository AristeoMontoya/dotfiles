local versions = require("settings.versions")
return {
	"saghen/blink.cmp",
	commit = versions.blink,
	enabled = false,
	dependencies = {
		-- LuaSnip commit kept in sync with your versions table
		{ "L3MON4D3/LuaSnip", commit = versions.luasnip },
		-- lazydev ships a first-party blink source, no extra adapter needed
		{ "folke/lazydev.nvim", commit = versions.lazydev, ft = "lua" },
		-- Native blink DAP source (replaces rcarriga/cmp-dap)
		-- https://github.com/mayromr/blink-cmp-dap
		"mayromr/blink-cmp-dap",
		-- Replaces hrsh7th/cmp-nvim-lsp — capabilities wired below in config
		{ "antosha417/nvim-lsp-file-operations", commit = versions.nvim_lsp_file_operations, config = true },
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

			-- ── Snippets ────────────────────────────────────────────────────────
			-- Delegates expand/jump/active to LuaSnip, matching your lsnip usage.
			snippets = { preset = "luasnip" },

			-- ── Keymaps (insert / select mode) ─────────────────────────────────
			-- preset = "none" so we own every binding – nothing inherited.
			--
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
				["<Tab>"] = { "select_and_accept", "snippet_forward", "show", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},

			-- ── Cmdline mode ────────────────────────────────────────────────────
			-- Mirrors the two cmp.setup.cmdline blocks:
			--   "/" → buffer source    (was cmp "/" setup)
			--   ":" → path + cmdline   (was cmp ":" setup)
			-- <C-j>/<C-k> are forwarded here so they work in command mode too,
			-- matching your original { "i", "c" } mode binding.
			cmdline = {
				keymap = {
					preset = "none",
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<C-e>"] = { "cancel", "fallback" },
					["<Tab>"] = { "select_and_accept", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
				},
				sources = function()
					local t = vim.fn.getcmdtype()
					if t == "/" or t == "?" then
						return { "buffer" }
					end
					if t == ":" then
						return { "path", "cmdline" }
					end
					return {}
				end,
			},

			-- ── Sources ─────────────────────────────────────────────────────────
			sources = {
				-- Default order: LSP first, then snippets, path, lazydev.
				-- Buffer is intentionally left out of default (commented in original).
				default = { "lsp", "snippets", "path", "lazydev" },

				per_filetype = {
					-- cmp_git has no blink port yet; buffer is the fallback used in
					-- the original anyway.
					gitcommit = { "buffer" },
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
					dap = {
						name = "DAP",
						module = "blink-cmp-dap",
					},
				},
			},

			-- ── Completion behaviour ────────────────────────────────────────────
			completion = {
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
						-- kind_icon | label + detail  [SourceName]
						-- SourceName replaces the vim_item.menu labels
						-- ([LSP], [Snip], [Path]) from the old format function.
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

			-- ── Appearance ──────────────────────────────────────────────────────
			-- Kind icons are a 1-for-1 port of the kind_icons table in cmp.lua.
			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "",
					Method = "",
					Function = "󰊕",
					Constructor = "",
					Field = "",
					Variable = "󰀫",
					Class = "",
					Interface = "",
					Module = "",
					Property = "",
					Unit = "",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "󰆐",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "",
					Event = "",
					Operator = "󰿈",
					TypeParameter = "󰅲",
				},
			},
		})

		-- Replaces cmp-nvim-lsp: wire blink's extended capabilities into every
		-- LSP server so servers know to send completion, snippet and labelDetails data.
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})
	end,
}
