local M = {}

local function get_directories()
	local directories = {}

	local handle = io.popen("fd . --type directory")
	if handle then
		for line in handle:lines() do
			table.insert(directories, line)
		end
		handle:close()
	else
		print("Failed to execute fd command")
	end

	return directories
end

function M.open_picker()
	local Snacks = require("snacks")
	local base_keymaps = require("plugins.editor.snacks._base-picker-keymaps")
	local base_layout = require("plugins.editor.snacks._base-picker-layout")

	local dirs = get_directories()

	return Snacks.picker({
		finder = function()
			local items = {}
			for i, item in ipairs(dirs) do
				table.insert(items, {
					idx = i,
					file = item,
					text = item,
				})
			end
			return items
		end,
		matcher = {
			frecency = true,
		},
		title = "Directories",
		layout = vim.tbl_deep_extend("force", base_layout, {}),
		format = function(item, _)
			local file = item.file
			local ret = {}
			local a = Snacks.picker.util.align
			local icon, icon_hl = Snacks.util.icon(file.ft, "directory")
			ret[#ret + 1] = { a(icon, 3), icon_hl }
			ret[#ret + 1] = { " " }
			ret[#ret + 1] = { a(file, 20) }

			return ret
		end,
		confirm = function(picker, item)
			picker:close()
			require("lib.toggle-oil")(item.file)
		end,
		win = {
			input = {
				keys = vim.tbl_deep_extend("force", base_keymaps, {}),
			},
		},
	})
end

function M.setup()
	vim.keymap.set("n", "<C-b>", M.open_picker)
end

return M
