return {
	"folke/snacks.nvim",
	lazy = false,
	---@type snacks.Config
	opts = {

		bigfile = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = false },
		--
		dashboard = { enabled = false },
		explorer = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	config = function()
		local Snacks = require("snacks")

		require("plugins.editor.snacks._file-picker").setup()
		require("plugins.editor.snacks._dir-picker").setup()
		require("plugins.editor.snacks._grep-picker").setup()
    require("plugins.editor.snacks._side-file-explorer").setup()

		vim.keymap.set("n", "<C-,>", function()
			Snacks.picker.resume()
		end)
	end,
}
