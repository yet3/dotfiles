return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	dependencies = {
		"MeanderingProgrammer/treesitter-modules.nvim",
		"windwp/nvim-ts-autotag",
	},
	lazy = false,
	build = ":TSUpdate",
	cmd = { "TSUpdateSync" },
	config = function()
		require("nvim-treesitter").setup({})

		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		})

		require("treesitter-modules").setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<A-o>",
					node_incremental = "<A-o>",
					scope_incremental = "<A-O>",
					node_decremental = "<A-i>",
				},
			},
		})

		require("nvim-treesitter").install({
			"vim",
			"vimdoc",
			"bash",

			"html",
			"javascript",
			"typescript",
			"tsx",
			"styled",
			"astro",
			"svelte",
			"graphql",
			"css",
			"scss",
			"prisma",

			"go",
			"gomod",
			"gosum",

			"c",
			"cpp",
			"zig",
			"lua",
			"json",

			"sql",

			"markdown",
			"markdown_inline",

			"query",
			"regex",
			"yaml",
			"toml",
			"dockerfile",
			"make",

			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
		})
	end,
}
