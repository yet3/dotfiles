---@param idx number
local accetpIdx = function(idx)
	---@param cmp blink.cmp.API
	return function(cmp)
		cmp.accept({ index = idx })
	end
end

local idxToKey = function(idx)
	local t = { "j", "k", "l", "u", "i", "o", "m", ",", ".", "h" }
	return t[idx] or ""
end

return {
	enabled = true,
	"saghen/blink.cmp",
	-- use a release tag to download pre-built binaries
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<CR>"] = { "accept", "fallback" },

			["<M-j>"] = { accetpIdx(1) },
			["<M-k>"] = { accetpIdx(2) },
			["<M-l>"] = { accetpIdx(3) },
			["<M-u>"] = { accetpIdx(4) },
			["<M-i>"] = { accetpIdx(5) },
			["<M-o>"] = { accetpIdx(6) },
			["<M-m>"] = { accetpIdx(7) },
			["<M-,>"] = { accetpIdx(8) },
			["<M-.>"] = { accetpIdx(9) },
			["<M-h>"] = { accetpIdx(10) },
		},
		completion = {
			accept = { auto_brackets = { enabled = true }, create_undo_point = true },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
				window = { border = "rounded" },
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
				border = "rounded",
				scrollbar = false,
				draw = {
					columns = {
						{ "quick_key", gap = 1 },
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" },
					},
					components = {
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
			window = { border = "rounded" },
		},

		appearance = {
			use_nvim_cmp_as_default = false,
		},

		snippets = { preset = "default" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			cmdline = {
				min_keyword_length = 2,
			},
			providers = {
				buffer = {
					name = "BUFFER",
					module = "blink.cmp.sources.buffer",
					score_offset = -10,
				},
			},
		},
	},
}
