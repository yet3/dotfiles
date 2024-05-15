-- vim.api.nvim_set_hl(0, 'DiffDelete', { fg = "#ffffff", bg = "#31748f" })

return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"rebelot/kanagawa.nvim",
	},
	opts = {
		highlight = {
			ui = "String",
			search = "SpectreSearch",
			replace = "SpectreReplace",
			-- replace = "SpectreReplace"
		},
	},
	config = function(M, opts)
		local spectre = safe_plug_load("spectre", M)
		spectre.setup(opts)

		vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Toggle Spectre",
		})
		vim.keymap.set("n", "<leader>sl", '<cmd>lua require("spectre").resume_last_search()<CR>', {
			desc = "Resume last search",
		})
		vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search on current file",
		})

		local colors = require("kanagawa.colors").setup { theme = "wave" }
		local theme = colors.theme
		vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.syn.identifier, fg = "#938056" })
		vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.syn.string, fg = theme.diff.add })
	end,
}
