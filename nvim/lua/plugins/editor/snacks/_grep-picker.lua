local M = {}

function M.open_picker()
	local Snacks = require("snacks")
	local base_keymaps = require("plugins.editor.snacks._base-picker-keymaps")
	local base_layout = require("plugins.editor.snacks._base-picker-layout")

	Snacks.picker.grep({
		matcher = {
			frecency = true,
		},
		layout = vim.tbl_deep_extend("force", base_layout, {}),
		win = {
			input = {
				keys = vim.tbl_deep_extend("force", base_keymaps, {
					["<C-r>"] = {
						function(picker)
							local query = picker:text()
							picker:close()
							require("grug-far").open({ prefills = { search = query } })
						end,
						mode = { "n", "i" },
					},
				}),
			},
		},
	})
end

function M.setup()
	vim.keymap.set("n", "<C-g>", M.open_picker)
end

return M
