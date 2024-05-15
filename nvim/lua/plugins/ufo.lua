return {
	-- enabled =false,
	"kevinhwang91/nvim-ufo",
	-- event = "BufReadPost",
	dependencies = {
		{ "kevinhwang91/promise-async" },
		{ "nvim-treesitter/nvim-treesitter" },
		{ "luukvbaal/statuscol.nvim" },
	},
	config = function(M)
		local statuscol = safe_plug_load("statuscol", M)
		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		local builtin = require "statuscol.builtin"
		statuscol.setup {
			foldfunc = "builtin",
			setopt = true,
			relculright = true,
			segments = {
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { "%s" }, click = "v:lua.ScSa" },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
			},
		}
		local ufo = safe_plug_load("ufo", M)

		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- vim.o.statuscolumn =
		-- '%=%l%s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*'

		map("n", "zO", require("ufo").openAllFolds)
		map("n", "zF", require("ufo").closeAllFolds)
		map("n", "zo", ":foldopen<CR>")
		map("n", "zf", ":foldclose<CR>")

		ufo.setup {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		}
	end,
}
