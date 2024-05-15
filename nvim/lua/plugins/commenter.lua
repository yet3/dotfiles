return {
	"numToStr/Comment.nvim",
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function(M)
		local comment = safe_plug_load("Comment", M)
		require("ts_context_commentstring").setup {
			enable_autocmd = false,
		}
		comment.setup {
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		}
	end,
}
