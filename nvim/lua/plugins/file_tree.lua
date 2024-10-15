return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		local oil = require("oil")
    local actions = require("oil.actions")
		oil.setup({
			columns = {
        "mtime",
				"size",
				"icon",
			},
			delete_to_trash = true,
			experimental_watch_for_changes = true,
			use_default_keymaps = false,
      skip_confirm_for_simple_edits = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-r>"] = "actions.refresh",

				["<C-s>"] = function ()
          actions.select_vsplit.callback()
          actions.close.callback()
				end,
				-- ["<C-h>"] = function ()
    --       actions.select_split.callback()
    --       actions.close.callback()
				-- end,

				-- ["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-q>"] = "actions.close",
				["<BS>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				-- ["`"] = "actions.cd",
				-- ["~"] = "actions.tcd",
				-- ["gs"] = "actions.change_sort",
				["E"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				-- ["g\\"] = "actions.toggle_trash",
			},
			view_options = {
				show_hidden = true,
			},
		})

		vim.keymap.set("n", "<leader>n", function()
			local buf_name = vim.fn.bufname(vim.api.nvim_get_current_buf())
			if string.find(buf_name, "oil://") then
				oil.close()
			else
				oil.open()
			end
		end)
	end,
}
