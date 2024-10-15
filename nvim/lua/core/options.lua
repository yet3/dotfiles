local opt = vim.opt

opt.confirm = true
opt.clipboard = "unnamedplus"

opt.termguicolors = true
opt.cursorline = true

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

opt.spelllang = { "en" }
opt.showmode = false

-- consider replacing this with a plugin
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200

local indent = 2
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.smarttab = true
opt.breakindent = true
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent

opt.mouse = ""
-- opt.mouse = "a"


opt.scrolloff = 16
-- End of file scroll off
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("ScrollOffEOF", {}),
	callback = function()
		local win_h = vim.api.nvim_win_get_height(0)
		local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
		local dist = vim.fn.line("$") - vim.fn.line(".")
		local rem = vim.fn.line("w$") - vim.fn.line("w0") + 1
		if dist < off and win_h - rem + dist < off then
			local view = vim.fn.winsaveview()
			view.topline = view.topline + off - (win_h - rem + dist)
			vim.fn.winrestview(view)
		end
	end,
})
