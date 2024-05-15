return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
	},
	opts = {},
	config = function(M, opts)
		local dap = safe_plug_load("dap", M)
		local dap_go = safe_plug_load("dap-go", M)

		dap_go.setup {}

		-- dap.adapters.delve = {
		--   type = 'server',
		--   port = '${port}',
		--   executable = {
		--     command = 'dlv',
		--     args = { 'dap', '-l', '127.0.0.1:${port}' },
		--     -- add this if on windows, otherwise server won't open successfully
		--     -- detached = false
		--   }
		-- }
		--
		-- dap.configurations.go = {
		--   {
		--     type = "delve",
		--     name = "Debug",
		--     request = "launch",
		--     program = "${file}"
		--   },
		--   {
		--     type = "delve",
		--     name = "Debug test", -- configuration for debugging test files
		--     request = "launch",
		--     mode = "test",
		--     program = "${file}"
		--   },
		--   -- works with go.mod packages and sub packages
		--   {
		--     type = "delve",
		--     name = "Debug test (go.mod)",
		--     request = "launch",
		--     mode = "test",
		--     program = "./${relativeFileDirname}"
		--   }
		-- }
	end,
}
