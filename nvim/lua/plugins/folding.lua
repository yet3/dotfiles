return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldcolumn = "0"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true


		local ufo = require("ufo")
		ufo.setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})

		-- Dsiable some mappings for folding
		-- vim.api.nvim_del_keymap("n", "zf") -- adds fold marker
		-- vim.api.nvim_del_keymap("n", "zd") -- removes fold marker
	end,
}
