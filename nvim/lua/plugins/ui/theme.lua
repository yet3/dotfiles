return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 99999,
		config = function()
			require("solarized-osaka").setup({
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "dark",
					floats = "dark",
				},
				sidebars = { "qf", "help" },
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = false,

				---@param colors ColorScheme
				on_highlights = function(highlights, colors)
					highlights.BlinkCmpMenu = { bg = colors.bg_float }
					highlights.BlinkCmpMenuBorder = { bg = colors.bg_float }
					highlights.BlinkCmpSource = { bg = colors.bg_float }
				end,
			})

			vim.cmd("colorscheme solarized-osaka")
		end,
	},
	-- {
	-- 	"lalitmee/cobalt2.nvim",
	-- 	dependencies = { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" },
	-- 	lazy = false,
	-- 	priority = 99999,
	-- 	init = function()
	-- 		require("colorbuddy").colorscheme("cobalt2")
	-- 	end,
	-- },
}
