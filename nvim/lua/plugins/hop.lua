return {
	"echasnovski/mini.jump2d",
	version = false,
	config = function()
		local mini = require("mini.jump2d")
		mini.setup({
			view = {
				dim = true,
			},
			mappings = {
				start_jumping = "",
			},
		})
		vim.keymap.set({ "n", "v" }, "s", function()
			mini.start(mini.builtin_opts.single_character)
		end)
	end,
}
