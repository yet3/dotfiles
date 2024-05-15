-- Loaded in plugins/core/init.lua
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- not sure about this one

local opt = vim.opt

opt.autowrite = false -- Auto save
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.wildignore:append { "*/node_modules/*" }

opt.conceallevel = 2
opt.confirm = true -- Confirm exiting buffer with unsaved changes

opt.formatoptions = "jcroqlnt" -- tcqj

opt.hlsearch = false
opt.incsearch = true
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- preview incremental substitute
opt.laststatus = 2
opt.list = false -- Show some invisible characters (tabs...
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold

opt.splitright = true
opt.splitbelow = true

opt.wildignorecase = true -- When set case is ignored when completing file names and directories
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.cmdheight = 1

local indent = 2
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.smarttab = true
opt.breakindent = true
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.wrap = false
opt.mouse = "a"

opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true -- Highlight the text line of the cursor with CursorLine |hl-CursorLine|
opt.winblend = 0
opt.wildoptions = "pum"
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
