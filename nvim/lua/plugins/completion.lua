local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local source_mapping = {
	nvim_lsp = "lsp",
	nvim_lua = "lua",
	luasnip = "snip",
	buffer = "buf",
	path = "path",
	treesitter = "tree",
	cmp_ai = "ai",
}

return {
	"iguanacucumber/magazine.nvim",
	name = "nvim-cmp", -- Otherwise highlighting gets messed up
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"js-everts/cmp-tailwind-colors",
		"ray-x/cmp-treesitter",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- local cmp_tailwind = require("cmp-tailwind-colors")
		local kind_icons = require("ui.icons").kinds
		local luasnip = require("luasnip")

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
				keyword_length = 1,
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = {
					border = "rounded",
				},
				documentation = {
					border = "rounded",
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

				["<C-Space>"] = cmp.mapping.complete(),
				["<C-q>"] = cmp.mapping.abort(),
				["<M-e>"] = cmp.mapping.abort(),
				["<Esc>"] = cmp.mapping(function()
					cmp.mapping.abort()
					vim.cmd("stopinsert")
				end),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
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
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{
					name = "luasnip",
					group_index = 1,
					priority = 8,
					option = { use_show_condition = true },
					entry_filter = function()
						local context = require("cmp.config.context")
						return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
					end,
				},
				{
					name = "nvim_lsp",
					group_index = 2,
					priority = 8,
				},
				{
					name = "lazydev",
					group_index = 0,
					priority = 5,
				},
				{
					name = "path",
					keyword_length = 4,
					group_index = 4,
					priority = 5,
				},
				{
					name = "treesitter",
					keyword_length = 4,
					group_index = 4,
					priority = 4,
				},
				{
					name = "buffer",
					keyword_length = 3,
					group_index = 5,
					priority = 3,
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
			}),
			sorting = {
				priority_weight = 1,
				comparators = {
					cmp.config.compare.locality,
					cmp.config.compare.recently_used,
					cmp.config.compare.score,
					cmp.config.compare.offset,
					cmp.config.compare.order,
					-- cmp.config.compare.exact,
					-- cmp.config.compare.kind,
					-- cmp.config.compare.sort_text,
					-- cmp.config.compare.length,
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				expandable_indicator = true,
				format = function(entry, item)
					if entry.source.name ~= nil and item.kind ~= nil then
						item.menu = "  " .. (source_mapping[entry.source.name] or "") .. ": " .. item.kind .. "  "
					else
						item.menu = "  (" .. item.kind .. ")  "
					end

					local should_add_icon = true
					if entry.source.get_debug_name(entry.source) == "nvim_lsp:tailwindcss" then
						-- local tw = deep_copy(item)
						-- tw = cmp_tailwind.format(entry, tw)
						-- if tw.kind_hl_group ~= nil and string.match(tw.kind_hl_group, "cmp_tailwind_colors_") then
						-- 	item.kind = tw.kind
						-- 	item.kind_hl_group = tw.kind_hl_group
						-- 	should_add_icon = false
						-- end
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
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
		})

		require("luasnip.loaders.from_snipmate").lazy_load()
	end,
}
