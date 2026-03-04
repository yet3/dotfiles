return {
	reverse = true,
	layout = {
		backdrop = true,
		row = 0,
		width = 0,
		height = 0.98,
		box = "vertical",
		{
			box = "vertical",
			border = "single",
			title = "{title} {live} {flags}",
			{ win = "list", border = "none" },
			{ win = "input", height = 1, border = "top" },
		},
		{ win = "preview", height = 0.6, title = "{preview}", border = "single" },
	},
}
