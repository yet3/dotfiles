return {
	"j-hui/fidget.nvim",
	opts = {},
	config = function(M, opts)
		local fidget = safe_plug_load("fidget", M)
		fidget.setup(opts)
	end,
}
