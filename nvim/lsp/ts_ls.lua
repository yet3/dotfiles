return {
	init_options = {
		tsserver = {
			-- Tell the internal tsserver process where to spit out its raw log files
			logDirectory = vim.fn.expand("~/.local/state/nvim/ts_ls_logs/"),
			logVerbosity = "verbose", -- Options: "terse", "normal", "verbose"
		},
	},
}
