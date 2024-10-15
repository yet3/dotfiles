local open_with_picker = function(prompt_bufnr)
	local action_state = require("telescope.actions.state")

	local cur_picker = action_state.get_current_picker(prompt_bufnr)
	cur_picker.get_selection_window = function(picker)
		local picked_window_id = require("window-picker").pick_window({
			filter_rules = {
				include_current_win = true,
			},
		}) or vim.api.nvim_get_current_win()
		picker.get_selection_window = nil
		return picked_window_id
	end

	return prompt_bufnr
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"s1n7ax/nvim-window-picker",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-smart-history.nvim",
		"kkharji/sqlite.lua",
	},
	config = function()
		local data = assert(vim.fn.stdpath("data")) --[[@as string]]

		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local action_set = require("telescope.actions.set")

		-- cmd = "v" | "h"
		local openSplitPicker = function(cmd)
			return function(prompt_bufnr)
				action_set.edit(open_with_picker(prompt_bufnr), cmd == "v" and "vnew" or "new")
			end
		end

		local common_mappings = {
			["<C-q>"] = actions.close,
			["<CR>"] = actions.select_default,
			["<C-k>"] = actions.move_selection_previous,
			["<C-j>"] = actions.move_selection_next,
		}

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				file_ignore_patterns = { "%.git", "cache", "node_modules" },
				path_display = { "truncate" },
				mappings = {
					n = vim.tbl_deep_extend("force", common_mappings, {
						["o"] = actions.select_default,
						["s"] = openSplitPicker("v"),
						["S"] = openSplitPicker("h"),
					}),
					i = vim.tbl_deep_extend("force", common_mappings, {
						["<C-s>"] = openSplitPicker("v"),
						["<C-S-s>"] = openSplitPicker("h"), -- I have no idea why this one is not working
					}),
				},
				layout_config = {
					prompt_position = "top",
					horizontal = {
						width = 0.9,
						height = 0.9,
					},
				},
				sorting_strategy = "ascending",
			},
			extensions = {
				fzf = {},
				wrap_results = true,
				history = {
					path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
					limit = 100,
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "smart_history")

		-- vim.keymap.set("n", "<space>ff", function()
		-- 	builtin.find_files({ hidden = true })
		-- end)
		-- vim.keymap.set("n", "<space>f.", builtin.resume)

		-- vim.keymap.set("n", "<space>fh", builtin.help_tags)
		-- vim.keymap.set("n", "<space>fg", builtin.live_grep)
		-- vim.keymap.set("n", "<space>fb", builtin.buffers)
		-- vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
	end,
}
