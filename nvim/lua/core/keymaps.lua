local map = vim.keymap.set

-- Change word under the cursor
-- move to next/prev instance by using n/N
-- replace next/prev instance by using .
map("n", "<LEADER>x", "*``cgn")

-- Unmap 'q' in normal mode
vim.keymap.set("n", "<M-q>", "q", { noremap = true })
vim.keymap.set("n", "q:", "q:i", { noremap = true })
vim.keymap.set("n", "q", "<Nop>", { noremap = true })

-- Resizing splits
map("n", "<C-S-l>", ":vertical resize +5<CR>")
map("n", "<C-S-h>", ":vertical resize -5<CR>")
map("n", "<C-S-j>", ":resize +5<CR>")
map("n", "<C-S-k>", ":resize -5<CR>")

-- Moving between splits
map("n", "<C-w>", "<C-w>w")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


-- Moving lines
map("n", "J", ":m+1<CR>") -- DOWN
map("n", "K", ":m-2<CR>") -- UP
map("v", "J", ":m'>+<CR>gv") -- UP
map("v", "K", ":m-2<CR>gv") -- DOWN

-- Indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Don't save to clipboard on d
map("n", "d", '"_d')
-- Don't save to clipboard on c
map("n", "c", '"_c')
-- Don't copy when pasting over something
map("x", "p", '"_dP')
-- Cut line on Shift+x
map("n", "X", "dd")

local replace_word_under_cursor = function()
	local text = vim.fn.expand("<cword>")
	if type(text) == "string" and #text > 0 then
		vim.api.nvim_input(":%s/" .. text .. "//gI<LEFT><LEFT><LEFT>")
	else
		vim.notify("Nothing to search", vim.log.levels.WARN)
	end
end

local replace_selected = function()
	local text = get_selected_text()
	if type(text) == "string" and #text > 0 then
		vim.api.nvim_input(":%s/" .. text .. "//gI<LEFT><LEFT><LEFT>")
	else
		vim.notify("Nothing to search", vim.log.levels.WARN)
	end
end

map("n", "<leader>sa", replace_word_under_cursor, { silent = false })
map("v", "<leader>sa", replace_selected, { silent = false })

local toggle_hlsearch = function(key)
	---@diagnostic disable-next-line
	if vim.opt.hlsearch:get() then
		vim.cmd.nohl()
		return ""
	else
		return key
	end
end

map("n", "<CR>", function()
	toggle_hlsearch("<CR>")
end, { expr = true })
map("n", "<Esc>", function()
	toggle_hlsearch("<Esc>")
end, { expr = true })

--  There is probably a better way of doing this
map("n", "<C-q>", function()
	local ft = vim.bo.filetype
	local bt = vim.bo.buftype
	if ft == "vim" and bt == "nofile" then
		vim.cmd("quit")
		return ""
	end

	if ft == "spectre_panel" or ft == "lazy" or ft == "mason" then
		vim.cmd("quit")
		return ""
	end

	return "<C-q>"
end)

--  There is probably a better way of doing this
map("n", "<CR>", function()
	local ft = vim.bo.filetype
	local bt = vim.bo.buftype
	if ft == "vim" and bt == "nofile" then
		vim.cmd("startinsert!")
		local enter_key = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
		vim.api.nvim_feedkeys(enter_key, "n", false)
		return ""
	end

	return "<CR>"
end, { noremap = true })
