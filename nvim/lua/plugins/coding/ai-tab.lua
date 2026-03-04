return {
	enabled = false,
	"leonardcser/cursortab.nvim",
	build = "cd server && go build",
	config = function()
		require("cursortab").setup({
			provider = {
				type = "sweep",
				url = "http://localhost:8000",
			},
		})
	end,
}
