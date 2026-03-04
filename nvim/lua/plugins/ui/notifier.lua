return {
	"j-hui/fidget.nvim",
	lazy = false,
	priority = 99998,
	config = {
		notification = {
			override_vim_notify = true,
			view = {
				stack_upwards = false,
			},
			window = {
				align = "top",
				x_padding = 1,
				y_padding = 1,
				border = "single",
				reflow = true,
				winblend = 0,
			},
		},
	},
}
