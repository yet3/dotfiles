---@param idx number
local accetpIdx = function(idx)
	return function(cmp)
		if cmp.is_active() then
			cmp.accept({ index = idx })
		end
		return true
	end
end

local idxToKey = function(idx)
	local t = { "g", "h", "l", "u", "i", "o", "m", "n", ",", "." }
	return t[idx] or ""
end

return {
	"saghen/blink.cmp",
	version = "1.*",
	opts = {
		cmdline = {
			completion = {
				menu = { auto_show = false },
			},
		},
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-q>"] = { "cancel", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<CR>"] = { "accept", "fallback" },

			["<C-g>"] = { accetpIdx(1), "fallback" },
			["<C-h>"] = { accetpIdx(2), "fallback" },
			["<C-l>"] = { accetpIdx(3), "fallback" },
			["<C-u>"] = { accetpIdx(4), "fallback" },
			["<C-i>"] = { accetpIdx(5), "fallback" },
			["<C-o>"] = { accetpIdx(6), "fallback" },
			["<C-m>"] = { accetpIdx(7), "fallback" },
			["<C-n>"] = { accetpIdx(8), "fallback" },
			["<C-,>"] = { accetpIdx(9), "fallback" },
			["<C-.>"] = { accetpIdx(10), "fallback" },

			["<Tab>"] = { "fallback" },
			["<S-Tab>"] = { "fallback" },
		},
		completion = {
			accept = {
				auto_brackets = { enabled = false },
				create_undo_point = true,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
				window = { border = "single" },
			},
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = {
					preselect = true,
				},
			},
			menu = {
				auto_show = true,
				border = "single",
				scrollbar = false,
				draw = {
					columns = {
						{ "quick_key", gap = 1 },
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" },
					},
					components = {
						kind_icon = {
							highlight = function(ctx)
								local default_hl = "BlinkCmpKind" .. ctx.kind

								if ctx.item.source_name == "LSP" then
									local ok, colors = pcall(require, "nvim-highlight-colors")

									if not ok then
										return default_hl
									end

									local color_item = colors.format(ctx.item.documentation, { kind = ctx.kind })
									if color_item and color_item.abbr_hl_group then
										return color_item.abbr_hl_group
									end
								end
								return default_hl
							end,
						},
						quick_key = {
							text = function(ctx)
								return ctx.idx > 10 and " " or idxToKey(ctx.idx)
							end,
							highlight = "BlinkCmpItemIdx",
						},
					},
				},
			},
		},
		signature = {
			enabled = true,
			window = { border = "single" },
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
