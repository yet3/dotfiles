local opt = vim.opt

opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.clipboard = 'unnamedplus'

opt.number = true
opt.title = true

opt.hlsearch = false
opt.incsearch = true
opt.inccommand = 'split' -- Shows what will be substituted in split (:%s)

opt.backup = false;
opt.swapfile = false;
opt.hidden = true;
opt.errorbells = false

opt.cmdheight = 1
opt.laststatus = 2
opt.scrolloff = 8
opt.signcolumn = 'yes'

opt.splitright = true
opt.splitbelow = true

opt.wildignorecase = true -- When set case is ignored when completing file names and directories
opt.wildmode = "full"


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
opt.mouse = 'a'

opt.termguicolors = true
opt.background = 'dark'
opt.cursorline = true -- Highlight the text line of the cursor with CursorLine |hl-CursorLine|
opt.winblend = 0
opt.wildoptions = 'pum'
opt.pumblend = 10

opt.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- A comma separated list of options for Insert mode completion
opt.wildignore:append { '*/node_modules/*' }
