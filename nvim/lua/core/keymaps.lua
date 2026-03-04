local map = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Change word under the cursor
-- move to next/prev instance by using n/N
-- replace next/prev instance by using .
map("n", "<LEADER>x", "*``cgn", {
	desc = "Change word under the cursor",
})

-- Map alt-q for recording macros instead of just 'q'
map("n", "<M-q>", "q", { noremap = true })
map("n", "q:", "q:i", { noremap = true })
map("n", "q", "<Nop>", { noremap = true })

-- Open last file
map("n", "<C-S-t>", "<cmd>e #<CR>", {
	desc = "Open last file",
})

-- Redo
map("n", "U", "<C-r>", { noremap = true, desc = "Redo" })

-- Indenting
map("v", "<", "<gv", {
	desc = "Indent left",
})
map("v", ">", ">gv", {
	desc = "Indent right",
})

-- Moving lines
map("n", "J", ":m+1<CR>", {
	desc = "Move lines down",
})
map("v", "J", ":m'>+<CR>gv", {
	desc = "Move lines down",
})
map("n", "K", ":m-2<CR>", {
	desc = "Move lines up",
})
map("v", "K", ":m-2<CR>gv", {
	desc = "Move lines up",
})

-- Resizing splits
map("n", "<C-S-l>", ":vertical resize +5<CR>", {
	desc = "Resize split vertically +5",
})
map("n", "<C-S-h>", ":vertical resize -5<CR>", {
	desc = "Resize split vertically -5",
})
map("n", "<C-S-j>", ":resize +5<CR>", {
	desc = "Resize split horizontally +5",
})
map("n", "<C-S-k>", ":resize -5<CR>", {
	desc = "Resize split horizontally -5",
})

-- Moving between splits
map("n", "<C-w>", "<C-w>w", {
	desc = "Swap split",
})
map("n", "<C-j>", "<C-w>j", {
	desc = "Move to split donwards",
})
map("n", "<C-k>", "<C-w>k", {
	desc = "Move to split upwards",
})
map("n", "<C-h>", "<C-w>h", {
	desc = "Move to split to the left",
})
map("n", "<C-l>", "<C-w>l", {
	desc = "Move to split to the right",
})

-- Don't save to clipboard on d
map("n", "d", '"_d')
-- Don't save to clipboard on c
map("n", "c", '"_c')
-- Don't copy when pasting over something
map("x", "p", '"_dP')
-- Cut line on Shift+x
map("n", "X", "dd")

map({ "i", "v" }, "<C-c>", "<Esc>")
map("n", "<C-c>", ":nohl<CR>")
