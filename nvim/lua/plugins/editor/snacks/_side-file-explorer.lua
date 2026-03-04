local M = {}

function M.open_side_explorer()
	local Snacks = require("snacks")
	---@type fun(opts?: snacks.picker.explorer.Config): snacks.Picker
	Snacks.explorer({
		win = {
			list = {
				keys = {
					["<Esc>"] = "close",
					["<C-q>"] = { "close", mode = { "i", "n" } },

					["<CR>"] = { "confirm", mode = { "n", "i" } },
					["<C-o>"] = { "confirm", mode = { "n", "i" } },
					["<C-s>"] = { "edit_vsplit", mode = { "i", "n" } },
				},
			},
		},
	})
end

function M.setup()
	vim.keymap.set("n", "<leader>m", M.open_side_explorer)
end

return M
