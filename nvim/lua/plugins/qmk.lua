return {
	"codethread/qmk.nvim",
	opts = {
		name = "LAYOUT_5x6",
		layout = {
			"x x x x x x _ _ _ _ _ x x x x x x",
			"x x x x x x _ _ _ _ _ x x x x x x",
			"x x x x x x _ _ _ _ _ x x x x x x",
			"x x x x x x _ _ _ _ _ x x x x x x",
			"_ _ x x _ _ _ _ _ _ _ _ _ x x _ _",
			"_ _ _ _ x x _ _ _ _ _ x x _ _ _ _",
			"_ _ _ _ _ _ x x _ x x _ _ _ _ _ _",
			"_ _ _ _ _ _ x x _ x x _ _ _ _ _ _",
		},
	},
	config = function(M, opts)
		local qmk = safe_plug_load("qmk", M)
		qmk.setup(opts)
	end,
}
