return {
	enabled = false,
	"echasnovski/mini.animate",
	version = "*",
	opts = {},
	config = function(M, opts)
		local anim = safe_plug_load("mini.animate", M)
		anim.setup(opts)
	end,
}
