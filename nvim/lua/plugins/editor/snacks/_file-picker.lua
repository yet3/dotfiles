local M = {}

function M.open_picker()
	local Snacks = require("snacks")
	local base_keymaps = require("plugins.editor.snacks._base-picker-keymaps")
	local base_layout = require("plugins.editor.snacks._base-picker-layout")

	Snacks.picker.files({
		debug = {
			scores = false,
		},
		matcher = {
			frecency = true,
		},
		layout = vim.tbl_deep_extend("force", base_layout, {}),
		actions = {
			open_dir = function(picker, item)
				picker:norm(function()
					if item then
						picker:close()
						require("lib.toggle-oil")(vim.fn.fnamemodify(item._path, ":h"))
					end
				end)
			end,
		},
		win = {
			input = {
				keys = vim.tbl_deep_extend("force", base_keymaps, {
					["<C-b>"] = {
						"open_dir",
						mode = { "n", "i" },
					},
				}),
			},
		},
	})
end

function M.setup()
	vim.keymap.set("n", "<C-f>", M.open_picker)
end

return M
