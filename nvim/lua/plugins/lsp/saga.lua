return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		border_style = "rounded",
		symbol_in_winbar = {
			enable = false,
			separator = "  ",
		},
		finder_action_keys = {
			open = "o",
			vsplit = "s",
			split = "S",
			quit = { "q", "e" },
			scroll_up = "<C-f>",
			scroll_down = "<C-d>",
		},
	},
	config = function(M, opts)
		local saga = safe_plug_load("lspsaga", M)
		saga.setup(opts)

		map("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>")
		map("n", "]d", ":Lspsaga diagnostic_jump_next<CR>")
		-- map("n", "gh", ":Lspsaga hover_doc ++quiet<CR>")
		map("n", "gh", ":lua vim.lsp.buf.hover()<CR>")
		map("n", "gd", ":Lspsaga lsp_finder<CR>")
		map("n", "gp", ":Lspsaga peek_definition<CR>")
		map("n", "gr", ":Lspsaga rename<CR>")
		map("n", "gl", ":Lspsaga show_line_diagnostics<CR>")
	end,
}
