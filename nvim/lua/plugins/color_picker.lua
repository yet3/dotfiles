return {
	"nvchad/minty",
	lazy = true,
	dependencies = {
		"nvchad/volt",
	},
	keys = {
		{
			"<C-t>",
			function()
				require("minty.huefy").open({ border = true })
			end,
			desc = "Color picker",
		},
	},
}
