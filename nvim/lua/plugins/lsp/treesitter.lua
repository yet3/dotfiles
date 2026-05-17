return {
	{
		"VonHeikemen/ts-enable.nvim",
		lazy = false,
		opts = {
			auto_init = true,
			auto_install = true,
			highlights = true,
			folds = false,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"romus204/tree-sitter-manager.nvim",
		},
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
}
