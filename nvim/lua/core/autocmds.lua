-- <C-q> in lazy and mason ui
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lazy", "mason" },
	callback = function()
		vim.keymap.set({ "n", "i", "v" }, "<C-q>", function()
			vim.cmd("quit")
		end, { buffer = true })
	end,
})
