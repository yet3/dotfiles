return {
	{
		enabled = false,
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			search = {
				exclude = {
					"notify",
					"cmp_menu",
					"noice",
					"flash_prompt",
					"neo-tree",
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"echasnovski/mini.jump2d",
		version = false,
		config = function()
			local mini = require "mini.jump2d"
			mini.setup {
				view = {
					dim = true,
				},
				mappings = {
					start_jumping = "",
				},
			}
			map("n", "s", function()
				mini.start(mini.builtin_opts.single_character)
			end)
		end,
	},
}
