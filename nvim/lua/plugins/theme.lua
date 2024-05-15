-- local M = {
--   "baliestri/aura-theme",
--   lazy = false,
--   priority = 1000
-- }
--
-- function M.config(plugin)
--   vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
--   vim.cmd([[colorscheme aura-dark]])
-- end
--
-- return M

-- return {
--   'rose-pine/neovim',
--   name = 'rose-pine',
--   lazy = false,
--   priority = 1000,
--   opts = {
--     highlight_groups = {
--       NormalFloat = { bg = 'base' },
--       LspFloatWinNormal = { bg = 'base' },
--       LspFloatWinBorder = { bg = 'base' },
--       Pmenu = { bg = 'base' },
--       CmpBorder = { bg = 'base' },
--
--       -- Telescope
--       TelescopeBorder = { fg = 'border', bg = 'NONE' }
--
--     }
--   },
--   config = function(M, opts)
--     local t = safe_plug_load('rose-pine', M)
--     t.setup(opts)
--     vim.cmd([[colorscheme rose-pine]])
--   end
--
-- }

-- local M = {
--     'folke/tokyonight.nvim',
--     priority = 1000,
-- }
--
-- function M.config()
--   vim.cmd('colorscheme tokyonight-night')
-- end

return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		overrides = function(colors)
			local theme = colors.theme
			local palette = colors.palette
			return {
				NormalFloat = { bg = theme.ui.bg },
				FloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg },
				LspFloatWinNormal = { bg = theme.ui.bg },
				LspFloatWinBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg },

				CmpBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg },
				-- CmpGhostText = { fg = theme.syn.preproc, bg = "NONE"},
				CmpGhostText = { fg = theme.ui.special, bg = "NONE" },
				Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg }, -- add `blend = vim.o.pumblend` to enable transparency
				-- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				-- PmenuSbar = { bg = theme.ui.bg_m1 },
				-- PmenuThumb = { bg = theme.ui.bg_p2 },

				-- Noice
				NoiceCmdlinePopupBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg },
				NoiceCmdlinePopupTitle = { bg = palette.oldWhite, fg = palette.sumiInk0 },
				NoiceCmdlineIcon = { fg = theme.ui.fg, bg = theme.ui.bg },

				-- Editor
				SignColumn = { fg = theme.ui.special, bg = theme.ui.bg },
				FoldColumn = { fg = theme.ui.nontext, bg = theme.ui.bg },
				LineNr = { fg = theme.ui.nontext, bg = theme.ui.bg },
				CursorLineNr = { fg = theme.diag.warning, bg = theme.ui.bg, bold = false },

				-- Git signs
				GitSignsAdd = { fg = theme.vcs.added, bg = theme.ui.bg },
				GitSignsChange = { fg = theme.vcs.changed, bg = theme.ui.bg },
				GitSignsDelete = { fg = theme.vcs.removed, bg = theme.ui.bg },

				-- Status line
				StatusLineBg = { bg = theme.ui.bg },
				StatusLineModeNormal = { fg = theme.ui.bg_dim, bg = "#9ccfd8" },
				StatusLineModeVisual = { fg = theme.ui.bg_dim, bg = "#ebbcba" },
				StatusLineModeInsert = { fg = theme.ui.bg_dim, bg = "#eb6f92" },
				StatusLineModeReplace = { fg = theme.ui.bg_dim, bg = "#eb6f92" },
				StatusLineModeCommand = { fg = theme.ui.bg_dim, bg = "#f6c177" },
				StatusLineModS = { fg = theme.ui.bg_dim, bg = "#c4a7e7" },
				StatusLineGitBranch = { bg = "#403d52", fg = "#f6c177" },
				StatusLineFile = { bg = "#403d52", fg = "#f6c177" },
				StatusLineFileModified = { bg = "#403d52", fg = "#9ccfd8" },
				StatusLineGitBlame = { bg = "#c4a7e7", fg = theme.ui.bg_dim },
				StatusLineCaretPos = { bg = "#c4a7e7", fg = theme.ui.bg_dim },

				-- Ident
				IndentLine = { fg = theme.syn.comment, bg = "NONE" },

				-- Spectre
				SpectreSearch = { bg = theme.vcs.changed, fg = theme.ui.fg },
				SpectreReplace = { bg = theme.vcs.added, fg = theme.ui.fg },

				--NeoTree
				NeoTreeFloatTitle = { bg = palette.oldWhite, fg = palette.sumiInk0 },

				-- Telescope
				TelescopeTitle = { bg = palette.oldWhite, fg = palette.sumiInk0 },

				-- mini.jump2d
				MiniJump2dSpot = { bg = palette.peachRed, fg = "white" },
			}
		end,
	},
	config = function(M, opts)
		local t = safe_plug_load("kanagawa", M)
		t.setup(opts)
		t.load "wave"
	end,
}
