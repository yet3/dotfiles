return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
	opts = {
		options = {
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { { "filename", path = 1, shorting_target = 40 } },

			lualine_x = {
				{ "searchcount", separator = "|" },
			},
			lualine_y = {
				"encoding",
				"filetype",
			},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },

			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			"oil",
			"lazy",
			"mason",
		},
	},
}
