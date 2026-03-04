return {
	"monaqa/dial.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<M-a>",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			mode = "n",
		},
		{
			"<M-x>",
			function()
				require("dial.map").manipulate("decrement", "normal")
			end,
			mode = "n",
		},
		--
		{
			"<M-a>",
			function()
				require("dial.map").manipulate("increment", "visual")
			end,
			mode = "x",
		},
		{
			"<M-x>",
			function()
				require("dial.map").manipulate("decrement", "visual")
			end,
			mode = "x",
		},
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.date.alias["%d.%m.%Y"],
				augend.date.alias["%H:%M"],
				augend.date.alias["%H:%M:%S"],
				augend.semver.alias.semver,
				augend.constant.alias.bool,
				augend.constant.new({ elements = { "let", "const" } }),
				augend.constant.new({ elements = { "and", "or" } }),
				augend.constant.new({ elements = { "&&", "||" } }),
			},
		})
	end,
}
