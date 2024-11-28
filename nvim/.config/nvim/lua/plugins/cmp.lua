local versions = require("settings.versions")
return {
	"hrsh7th/nvim-cmp",
	commit = versions.nvim_cmp,
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp", commit = versions.cmp_nvim_lsp },
		{ "hrsh7th/cmp-buffer", commit = versions.cmp_buffer },
		{ "hrsh7th/cmp-path", commit = versions.cmp_path },
		{ "hrsh7th/cmp-cmdline", commit = versions.cmp_cmdline },
		{ "hrsh7th/cmp-omni", commit = versions.cmp_omni },
		{ "rcarriga/cmp-dap", commit = versions.cmp_dap },
		{ "L3MON4D3/LuaSnip", commit = versions.LuaSnip },
		{ "saadparwaiz1/cmp_luasnip", commit = versions.cmp_luasnip },
	},
	config = function()
		-- Setup nvim-cmp.
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local lsnip = require("luasnip")
		local cmp = require("cmp")

		local kind_icons = {
			Text = "",
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
		}

		cmp.setup({
			formatting = {
				expandable_indicator = true,
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
					-- Source
					vim_item.menu = ({
						path = "[Path]",
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
					})[entry.source.name]
					return vim_item
				end,
			},
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = {
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-X><C-O>"] = cmp.mapping.complete(),
				["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					elseif lsnip.expand_or_locally_jumpable() then
						lsnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif lsnip.jumpable(-1) then
						lsnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For ultisnips users.
				{ name = "path" }, -- For ultisnips users.
			}, {
				-- { name = 'buffer' },
			}),
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			window = {
				completion = {
					border = "rounded",
				},
				documentation = {
					border = "rounded",
				},
			},
			enabled = function()
				return V.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
			end,
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline("/", {
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
			sources = {
				{ name = "dap" },
			},
		})

		cmp:confirm({ commit_character = nil or "(" or "." })
	end,
}
