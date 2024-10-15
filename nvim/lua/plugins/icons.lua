return {
	"echasnovski/mini.icons",
	version = false,
	config = function()
		local mini = require("mini.icons")
		mini.setup({
			style = "glyph",
		})
    mini.mock_nvim_web_devicons();
	end,
}
