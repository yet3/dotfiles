return {
	-- {
	-- 	"VonHeikemen/ts-enable.nvim",
	-- 	lazy = false,
	-- 	opts = {
	-- 		auto_init = true,
	-- 		auto_install = true,
	-- 		highlights = true,
	-- 		folds = false,
	-- 	},
	-- },
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		config = function()
			require("tree-sitter-manager").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			-- "VonHeikemen/ts-enable.nvim",
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
