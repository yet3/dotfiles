local function normalized_path()
	local Path = require("plenary.path")
	local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	return Path:new(buf_name):make_relative(vim.loop.cwd())
end

local function harpoon_idx()
	local harpoon = require("harpoon")
	local item, idx = harpoon:list():get_by_value(normalized_path())

	if item == nil then
		return ""
	end

	return "Harpoon: " .. idx
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim", "ThePrimeagen/harpoon" },
	opts = {
		options = {
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },

			lualine_x = { { harpoon_idx, draw_empty = false }, "encoding", "filetype" },
			lualine_y = {},
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
			"toggleterm",
		},
	},
}
