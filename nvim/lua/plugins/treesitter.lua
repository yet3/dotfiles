return {
	"nvim-treesitter/nvim-treesitter",
	tag = "v0.9.3",
	build = ":TSUpdate",
	lazy = false,
	dependencies = {
		{ "windwp/nvim-ts-autotag" },
	},
	cmd = { "TSUpdateSync" },
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
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
				"python",
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
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			}
		})

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
})
	end,
}
