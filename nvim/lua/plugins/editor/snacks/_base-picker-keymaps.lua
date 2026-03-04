return {
	["<Esc>"] = "close",
	["<C-q>"] = { "close", mode = { "i", "n" } },

	["/"] = "toggle_focus",

	["<CR>"] = { "confirm", mode = { "n", "i" } },
	["<C-o>"] = { "confirm", mode = { "n", "i" } },
	["<C-s>"] = { "edit_vsplit", mode = { "i", "n" } },

	["<M-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
	["<M-d>"] = { "preview_scroll_down", mode = { "i", "n" } },

	["<C-d>"] = { "list_scroll_down", mode = { "i", "n" } },
	["<C-u>"] = { "list_scroll_up", mode = { "i", "n" } },
	["<C-j>"] = { "list_down", mode = { "i", "n" } },
	["<C-k>"] = { "list_up", mode = { "i", "n" } },
	["j"] = "list_down",
	["k"] = "list_up",

	["<C-f>"] = {
		function(picker)
			picker:close()
			require("plugins.editor.snacks._file-picker").open_picker()
		end,
		mode = { "n", "i" },
	},
	["<C-g>"] = {
		function(picker)
			picker:close()
			require("plugins.editor.snacks._grep-picker").open_picker()
		end,
		mode = { "n", "i" },
	},
	["<C-b>"] = {
		function(picker)
			picker:close()
			require("plugins.editor.snacks._dir-picker").open_picker()
		end,
		mode = { "n", "i" },
	},
}
