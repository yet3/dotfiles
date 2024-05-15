local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local source_mapping = {
	nvim_lsp = "lsp",
	nvim_lua = "lua",
	luasnip = "snip",
	buffer = "buf",
	path = "path",
	treesitter = "tree",
	cmp_ai = "ai",

	-- nvim_lsp = "[LSP]",
	-- nvim_lua = "[LUA]",
	-- luasnip = "[SNIP]",
	-- buffer = "[BUF]",
	-- path = "[PATH]",
	-- treesitter = "[TREE]",
	-- cmp_ai = "[AI]",
}

local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"windwp/nvim-autopairs",
		"js-everts/cmp-tailwind-colors",
		"ray-x/cmp-treesitter",
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
	},
	config = function(opts, M)
		local cmp = require "cmp"
		local cmp_autopairs = require "nvim-autopairs.completion.cmp"
		local cmp_tailwind = require "cmp-tailwind-colors"
		local kind_icons = require("utils.ui.icons").kinds
		local luasnip = require "luasnip"

		-- local autocomplete_group = vim.api.nvim_create_augroup("dadbod-autocomplete", { clear = true })
		-- vim.api.nvim_create_autocmd("FileType", {
		--   pattern = { "sql", "mysql", "plsql" },
		--   callback = function()
		--     cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
		--   end,
		--   group = autocomplete_group,
		-- })

		cmp.setup {
			-- enabled = function()
			-- 	return require("util.cmp").is_enabled()
			-- end,
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			preselect = cmp.PreselectMode.Item,
			keyword_length = 2,
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = {
					winhighlight = "Normal:Pmenu",
					border = make_border(),
					col_offset = -3,
					side_padding = 0,
				},
				documentation = {
					winhighlight = "Normal:Pmenu",
					border = make_border(),
				},
			},
			view = {
				entries = { name = "custom", selection_order = "near_cursor" },
			},
			mapping = cmp.mapping.preset.insert {
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
				["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-q>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				["<S-CR>"] = cmp.mapping.confirm { select = true },
				["<C-CR>"] = function(fallback)
					cmp.abort()
					fallback()
				end,
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<Esc>"] = cmp.mapping(function()
					cmp.mapping.abort()
					vim.cmd "stopinsert"
				end),
			},
			sources = cmp.config.sources {
				{
					name = "luasnip",
					group_index = 1,
					option = { use_show_condition = true },
					entry_filter = function()
						local context = require "cmp.config.context"
						return not context.in_treesitter_capture "string" and not context.in_syntax_group "String"
					end,
				},
				{
					name = "nvim_lsp",
					group_index = 2,
				},
				{
					name = "nvim_lua",
					group_index = 3,
				},
				{
					name = "path",
					keyword_length = 4,
					group_index = 4,
				},
				{
					name = "treesitter",
					keyword_length = 4,
					group_index = 4,
				},
				{
					name = "buffer",
					keyword_length = 3,
					group_index = 5,
					option = {
						get_bufnrs = function()
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				expandable_indicator = true,
				format = function(entry, item)
					if entry.source.name ~= nil then
						item.menu = "  " .. (source_mapping[entry.source.name] or "") .. ": " .. item.kind .. "  "
					else
						item.menu = "  (" .. item.kind .. ")  "
					end

					local should_add_icon = true
					if entry.source.get_debug_name(entry.source) == "nvim_lsp:tailwindcss" then
						local tw = deep_copy(item)
						tw = cmp_tailwind.format(entry, tw)
						if tw.kind_hl_group ~= nil and string.match(tw.kind_hl_group, "cmp_tailwind_colors_") then
							item.kind = tw.kind
							item.kind_hl_group = tw.kind_hl_group
							should_add_icon = false
						end
					end

					if should_add_icon then
						local icon = ""
						if kind_icons[item.kind] then
							icon = kind_icons[item.kind]
						end
						item.kind = " " .. icon
					end

					return item
				end,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			experimental = {
				native_menu = false,
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
		}

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		require("luasnip.loaders.from_snipmate").lazy_load()

		local s, sn = luasnip.snippet, luasnip.snippet_node
		local t, i, d = luasnip.text_node, luasnip.insert_node, luasnip.dynamic_node
		luasnip.add_snippets("typescript", {
			s({
				trig = "todo",
				name = "todo",
				dscr = "Add a _todo with id",
			}, {
				t "_todo(`",
				i(1, ""),
				t '`, "',
				d(2, function()
					return sn(nil, i(1, "todo_" .. make_id(4)))
				end),
				t '");',
			}),
		})

		luasnip.add_snippets("typescriptreact", {
			s({
				trig = "todo",
				name = "todo",
				dscr = "Add a _todo with id",
			}, {
				t "_todo(`",
				i(1, ""),
				t '`, "',
				d(2, function()
					return sn(nil, i(1, "todo_" .. make_id(4)))
				end),
				t '");',
			}),
		})
	end,
}

-- function M.config()
--   local cmp = require("cmp")
--   local luasnip = require("luasnip")
--   local defaults = require("cmp.config.default")()
--   local sources = cmp.config.sources({
--     { name = "nvim_lsp" },
--     { name = "luasnip" },
--     { name = "path" },
--   }, {
--     { name = "buffer" },
--   })
--
--   for _, source in ipairs(sources) do
--     source.group_index = source.group_index or 1
--   end
--
--   local cmp = require("cmp")
--
--   cmp.setup({
--     completion = {
--       completeopt = "menu,menuone,noinsert",
--     },
--     snippet = {
--       expand = function(args)
--         require("luasnip").lsp_expand(args.body)
--       end,
--     },
--     sources = sources,
--     formatting = {
--       fields = { "kind", "abbr", "menu" },
--       expandable_indicator = true,
--       format = function(entry, item)
--         local icons = require("utils.ui.icons").kinds
--         local icon = ""
--         if icons[item.kind] then
--           icon = icons[item.kind]
--         end
--         item.menu = "  (" .. item.kind .. ")  "
--         item.kind = " " .. icon
--         return item
--       end,
--     },
--     window = {
--       completion = {
--         winhighlight = "Normal:Pmenu",
--         border = make_border(),
--         col_offset = -3,
--         side_padding = 0,
--       },
--       documentation = {
--         winhighlight = "Normal:Pmenu",
--         border = make_border(),
--       },
--     },
--     experimental = {
--       ghost_text = {
--         hl_group = "CmpGhostText",
--       },
--     },
--     sorting = defaults.sorting,
--   })
--
--   local cmp_autopairs = require("nvim-autopairs.completion.cmp")
--   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
--
--   require("luasnip.loaders.from_snipmate").lazy_load()
-- end

return M
