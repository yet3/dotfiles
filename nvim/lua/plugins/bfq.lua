return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	opts = {},
	setup = function(opts, M)
		local bqf = safe_plug_load("bqf", opts)
		bqf.setup(opts)
	end,
}
