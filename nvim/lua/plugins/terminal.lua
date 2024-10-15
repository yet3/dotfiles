local on_open = function(term)
	local set = vim.opt_local
	set.number = false
	set.relativenumber = false
	set.scrolloff = 0
	set.signcolumn = "no"

	local opts = { buffer = term.bufnr }

  vim.cmd[[hi ToggleTerm1Normal guibg=#0c0d14]]
	vim.keymap.set({ "n", "t" }, "<C-q>", "<cmd>close<CR>", { buffer = opts.buffer, noremap = true, silent = true })
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

	vim.cmd("startinsert!")
end

-- TODO: remove
-- local get_term_win = function(nr)
-- 	local bufs = vim.api.nvim_list_bufs()
-- 	local buf = -1
-- 	for _, v in ipairs(bufs) do
-- 		local name = vim.api.nvim_buf_get_name(v)
-- 		if name ~= nil and string.find(name, "#toggleterm#" .. nr) then
-- 			buf = v
-- 		end
-- 	end
--
-- 	if buf >= 0 then
-- 		local info = vim.fn.getbufinfo(buf)
-- 		local win = info[1].windows[1]
--
-- 		if win ~= nil then
-- 			return win
-- 		end
-- 	end
--
-- 	return -1
-- end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = nil,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local term_main = Terminal:new({
			direction = "tab",
			on_open = on_open,
		})

		vim.keymap.set("n", "<leader>tt", function()
			term_main:toggle()
		end, { noremap = true, silent = true })

		-- local term_bottom_win = nil
		-- local term_bottom = Terminal:new {
		-- 	direction = "horizontal",
		-- 	on_open = function(term)
		-- 		term_bottom_win = term.window
		-- 	end,
		-- 	on_close = function()
		-- 		term_bottom_win = nil
		-- 	end,
		-- }
		--
		-- vim.keymap.set("n", "<leader>tb", function()
		-- 	if term_bottom_win ~= nil then
		-- 		vim.api.nvim_set_current_win(term_bottom_win)
		-- 	else
		-- 		term_bottom:toggle()
		-- 	end
		-- end, { noremap = true, silent = true })
		--
		-- local term_right_win = nil
		-- local term_right = Terminal:new {
		-- 	direction = "vertical",
		-- 	on_open = function(term)
		--       vim.cmd"vertical resize 60"
		-- 		term_right_win = term.window
		-- 	end,
		-- 	on_close = function()
		-- 		term_right_win = nil
		-- 	end,
		-- }
		-- vim.keymap.set("n", "<leader>tr", function()
		-- 	if term_right_win ~= nil then
		-- 		vim.api.nvim_set_current_win(term_right_win)
		-- 	else
		-- 		term_right:toggle()
		-- 	end
		-- end, { noremap = true, silent = true })

		local term_lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "tab",
			on_open = on_open,
		})

		vim.keymap.set("n", "<leader>tg", function()
			term_lazygit:toggle()
		end, { noremap = true, silent = true })
	end,
}
