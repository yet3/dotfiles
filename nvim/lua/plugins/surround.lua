return {
  enabled = false,
	"echasnovski/mini.surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = {
		mappings = {
			add = "<M-s>a", -- Add surrounding in Normal and Visual modes
			delete = "<M-s>d", -- Delete surrounding
			find = "<M-s>f", -- Find surrounding (to the right)
			find_left = "<M-s>F", -- Find surrounding (to the left)
			highlight = "<M-s>h", -- Highlight surrounding
			replace = "<M-s>r", -- Replace surrounding
		},
	},
}
