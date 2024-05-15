return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function(M, opts)
		local ts = safe_plug_load("typescript-tools", M)

		ts.setup(opts)
	end,
}
