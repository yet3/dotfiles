return {
	{
		"romus204/tree-sitter-manager.nvim",
		lazy = true,
		cmd = { "TSInstall", "TSManager", "TSUpdate", "TSLog", "TSUninstall" },
		opts = {
			ensure_installed = {
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
				"rust",
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
			},
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
