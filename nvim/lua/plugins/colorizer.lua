return {
	"NvChad/nvim-colorizer.lua",
	priority = 0,
	config = function(M, opts)
		local colorizer = safe_plug_load("colorizer", M)
		colorizer.setup(opts)
	end,
}
