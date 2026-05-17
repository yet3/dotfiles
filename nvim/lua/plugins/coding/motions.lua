return {
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
			{ "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
		},
	},
	-- {
	-- 	"https://codeberg.org/andyg/leap.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("leap").opts.preview = function(ch0, ch1, ch2)
	-- 			return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
	-- 		end
	--
	-- 		vim.api.nvim_create_autocmd("ColorScheme", {
	-- 			group = vim.api.nvim_create_augroup("LeapBackdrop", {}),
	-- 			callback = function()
	-- 				if vim.g.colors_name == "this_color_scheme_needs_backdrop" then
	-- 					require("leap.user").set_backdrop_highlight("Comment")
	-- 				end
	-- 			end,
	-- 		})
	--
	-- 		vim.keymap.set({ "n", "x", "o" }, "z", "<Plug>(leap)")
	-- 		vim.keymap.set("n", "Z", "<Plug>(leap-from-window)")
	--
	-- 		-- vim.keymap.set({ "x", "o" }, "an", function()
	-- 		-- 	require("leap.treesitter").select({
	-- 		-- 		opts = require("leap.user").with_traversal_keys("n", "N"),
	-- 		-- 	})
	-- 		-- end)
	-- 	end,
	-- },
	{
		"nvim-mini/mini.jump2d",
		version = false,
		config = function()
			local mini = require("mini.jump2d")
			mini.setup()
			vim.keymap.set({ "n", "x", "o" }, "z", function()
				mini.start(mini.builtin_opts.single_character)
			end)
		end,
	},
}
