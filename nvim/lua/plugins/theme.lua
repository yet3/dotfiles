-- return {
-- 	"scottmckendry/cyberdream.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("cyberdream").setup({
-- 			transparent = true,
-- 			italic_comments = true,
-- 		})
-- 		vim.cmd("colorscheme cyberdream")
-- 	end,
-- }


return {
	"tiagovla/tokyodark.nvim",
  -- "folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyodark").setup({
			transparent_background = true,
			terminal_colors = false,
			custom_highlights = function(_, palette)
				return {
					Visual = { bg = palette.bg3 },
          MsgArea = { bg = palette.bg1 },

					CmpGhostText = { fg = "#5B7548", bg = "NONE" },
					CursorLine = { bg = palette.bg1 },

					TelescopeSelection = { bg = palette.bg3 },
					TelescopeMatching = { bg = "NONE", fg = palette.green },

					MiniJump2dSpot = { bg = palette.green, fg = palette.black },

					-- ToggleTerm1Normal = { bg = palette.bg0 },

					-- This has to be done after spectre is setup
					-- SpectreSearch = { bg = palette.red, fg = palette.black },
					-- SpectreReplace = { bg = palette.green, fg = palette.black },
				}
			end,
		})
		vim.cmd([[colorscheme tokyodark]])
	end,
}
