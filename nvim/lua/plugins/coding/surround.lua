return {
	"echasnovski/mini.surround",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		mappings = {
			add = "sa", -- Add surrounding in Normal and Visual modes
			delete = "sd", -- Delete surrounding
			find = "sf", -- Find surrounding (to the right)
			find_left = "sF", -- Find surrounding (to the left)
			highlight = "sh", -- Highlight surrounding
			replace = "sr", -- Replace surrounding

			suffix_last = "l", -- Suffix to search with "prev" method
			suffix_next = "n", -- Suffix to search with "next" method
		},
    n_lines = 50,
	},
}
