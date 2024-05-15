return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true,
		fast_wrap = {},
	},
	config = function(M, opts)
		local pairs = safe_plug_load("nvim-autopairs", M)
		pairs.setup(opts)
	end,
}
