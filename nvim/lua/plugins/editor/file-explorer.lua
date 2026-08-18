return {
	"stevearc/oil.nvim",
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	keys = {
		{
			"<leader>n",
			require("lib.toggle-oil"),
			mode = "n",
		},
		{
			"<leader>m",
			function(path)
				require("oil").open(path or nil)
			end,
			mode = "n",
		},
	},
	config = function()
		local oil = require("oil")
		local actions = require("oil.actions")

		oil.setup({
			default_file_explorer = true,
			columns = {
				"mtime",
				"size",
				"icon",
			},
			delete_to_trash = true,
			watch_for_changes = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			constrain_cursor = "editable",
			view_options = {
				show_hidden = true,
			},
			float = {
				border = "single",
				padding = 0,
				-- max_width = 0,
				-- max_height = 0.98,
				max_width = 0.6,
				max_height = 0.8,
				win_options = {
					winblend = 0,
				},
				override = function(conf)
					return vim.tbl_deep_extend("force", conf, {
						row = 4,
					})
				end,
			},
			confirmation = {
				border = "single",
			},
			use_default_keymaps = false,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-r>"] = "actions.refresh",
				["E"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["<C-p>"] = "actions.preview",
				["<C-q>"] = "actions.close",
				["<BS>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				--
				["<C-s>"] = function()
					actions.select_vsplit.callback()
					-- actions.close.callback()
				end,
				["<C-w>"] = function() end,
				["<C-l>"] = function() end,
				["<C-h>"] = function() end,
				["<C-j>"] = function() end,
				["<C-k>"] = function() end,
				--
				["<C-f>"] = function()
					actions.close.callback()
					require("plugins.editor.snacks._file-picker").open_picker()
				end,
				["<C-g>"] = function()
					actions.close.callback()
					require("plugins.editor.snacks._grep-picker").open_picker()
				end,
				["<C-b>"] = function()
					actions.close.callback()
					require("plugins.editor.snacks._dir-picker").open_picker()
				end,
			},
		})
	end,
}
