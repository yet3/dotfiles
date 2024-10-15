return {
	enabled = false,
	dir = "~/dev/better-cmdline.nvim",
	config = function()
		local t = require("better-cmdline")
		local act = require("better-cmdline.actions")
		t.setup({})

		t.vim.keymap.set("n", "<leader>zm", function()
			act.open.call()
		end)

		vim.keymap.set({ "n", "i" }, "<CR>", function()
			act.execute.call()
		end, { silent = true })
	end,
}
