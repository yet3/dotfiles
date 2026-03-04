return {
	"MagicDuck/grug-far.nvim",
	event = "VeryLazy",
	cmd = { "GrugFar", "GrugFarWithin" },
	opts = {
		keymaps = {
			close = { n = "<C-q>", i = "<C-q>", v = "<C-q>" },
		},
	},
}
