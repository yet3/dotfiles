vim.g.mapleader = " "

local opt = vim.opt

-- Confirm exiting buffer with unsaved changes
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
opt.scrolloff = 8
opt.signcolumn = "yes"

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append "c"

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

opt.spelllang = { "en" }
opt.showmode = false

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
opt.wrap = false
opt.mouse = "a"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
