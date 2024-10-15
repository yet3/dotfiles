return {
	"s1n7ax/nvim-window-picker",
	event = "VeryLazy",
	version = "2.*",
	opts = {
		hint = "floating-big-letter",
		show_prompt = false,
		filter_rules = {
			include_current_win = false,
			autoselect_one = true,
			bo = {
				filetype = { "NvimTree", "neo-tree", "neo-tree-popup", "notify", "fidget" },
				buftype = { "terminal", "quickfix", "nofile" },
			},
		},
	},
}
