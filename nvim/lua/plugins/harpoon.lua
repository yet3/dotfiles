return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		harpoon:extend({
			UI_CREATE = function(data)
				vim.keymap.set({ "n", "i", "v" }, "<C-q>", function()
					harpoon.ui:close_menu()
				end, { buffer = data.bufnr })
			end,
		})

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
			vim.notify("Added harpoon")
			require("lualine").refresh()
		end)
		vim.keymap.set("n", "<leader>q", function()
			harpoon:list():remove()
			vim.notify("Removed harpoon")
			require("lualine").refresh()
		end)

		vim.keymap.set("n", "<leader>r", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- vim.keymap.set("n", "<leader>q", function()
		-- 	harpoon.ui:close_menu()
		-- end)

		vim.keymap.set("n", "<leader><C-u>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader><C-j>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<M-n>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<M-j>", function()
			harpoon:list():select(4)
		end)
	end,
}
