-- Change word under the cursor
-- move to next/prev instance by using n/N
-- replace next/prev instance by using .
map("n", "<LEADER>x", "*``cgn")

-- Toggle spell checking
map("n", "<F2>", ":set spell!<CR>")
map("i", "<F2>", ":set spell!<CR>")

-- Inc/Dec number under cursor
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Window splits
map("n", "<C-v>", ":vsplit<CR>")
map("n", "<C-s>", ":split<CR>")

-- Moving between splits
map("n", "<C-w>", "<C-w>w")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Rotating splits
map("n", "<C-R>", "<C-w>R")
map("n", "<C-r>", "<C-w>r")

-- Resizing splits
map("n", "<C-S-l>", ":vertical resize +5<CR>")
map("n", "<C-S-h>", ":vertical resize -5<CR>")
map("n", "<C-S-j>", ":resize +5<CR>")
map("n", "<C-S-k>", ":resize -5<CR>")

map("v", "<", "<gv", { desc = "Indent lines out" })
map("v", ">", ">gv", { desc = "Indent lines in" })

-- Moving lines
map("n", "J", ":m+1<CR>")
map("n", "K", ":m-2<CR>")
map("v", "J", ":m'>+<CR>gv")
map("v", "K", ":m-2<CR>gv")

-- Switching Buffers
map("n", "<Tab>", ":bn<CR>")
map("n", "<S-Tab>", ":bp<CR>")

-- Select entire file
map("n", "<C-a>", "ggVG")
map("i", "<C-a>", "<Esc>ggVG")

map("n", "d", '"_d') -- Dont't save to clipboard on d
map("n", "c", '"_c') -- Dont' save to clipboard on c
map("x", "p", '"_dP') -- Dont't copy when pasting over something
map("n", "X", "dd") -- Cut line on Shift+x

-- map("n", "<leader>sa", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local searchAndReplaceInFileUnderCursor = function()
	local text = vim.fn.expand "<cword>"
	if type(text) == "string" and #text > 0 then
		vim.api.nvim_input(":%s/" .. text .. "//gI<LEFT><LEFT><LEFT>")
	else
		vim.notify("Nothing to search", vim.log.levels.WARN)
	end
end
map("n", "<leader>sa", searchAndReplaceInFileUnderCursor, { silent = false })

local searchAndReplaceInFileSelected = function()
	local text = get_v_selected_text()
	if type(text) == "string" and #text > 0 then
		vim.api.nvim_input(":%s/" .. text .. "//gI<LEFT><LEFT><LEFT>")
	else
		vim.notify("Nothing to search", vim.log.levels.WARN)
	end
end
map("v", "<leader>sa", searchAndReplaceInFileSelected, { silent = false })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("i", "<C-[>", "<Esc>")
map("v", "<C-[>", "<Esc>")
map("x", "<C-[>", "<Esc>")
map("i", "<C-;>", "<Esc>")
map("v", "<C-;>", "<Esc>")
map("x", "<C-;>", "<Esc>")

map("n", "<Leader>n", ":Neotree toggle<CR>")
map("n", "<Leader>m", ":Neotree reveal<CR>")
