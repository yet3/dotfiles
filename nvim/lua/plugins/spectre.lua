return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local spectre = require("spectre")
		spectre.setup({
			highlight = {
				ui = "String",
				search = "SpectreSearch",
				replace = "SpectreReplace",
			},
			replace_engine = {
				["sed"] = {
					cmd = "sed",
					args = {
						"-i",
						"",
						"-E",
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>ss", spectre.toggle)
		vim.keymap.set("n", "<leader>sl", spectre.resume_last_search)
		vim.keymap.set("n", "<leader>sw", function()
			spectre.open_visual({ select_word = true })
		end)
		vim.keymap.set("v", "<leader>sw", spectre.open_visual)
		vim.keymap.set("n", "<leader>sp", function()
			spectre.open_file_search({ select_word = true })
		end)

		-- local colors = require("kanagawa.colors").setup({ theme = "wave" })
		-- local theme = colors.theme
		vim.api.nvim_set_hl(0, "SpectreReplace", { bg = "#95C561", fg = "#06080A" })
		vim.api.nvim_set_hl(0, "SpectreSearch", { bg = "#EE6D85", fg = "#06080A" })
		vim.api.nvim_set_hl(0, "SpectreFile", { fg = "#A485DD" })
	end,
}
