return {
	"rcarriga/nvim-notify",
	opts = {
		top_down = false,
	},
	config = function(M, opts)
		local notify = safe_plug_load("notify", M)
		notify.setup(opts)
		vim.notify = notify
	end,
}
