local load_textobjects = false
return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ "windwp/nvim-autopairs" },
		{ "windwp/nvim-ts-autotag" },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			init = function()
				load_textobjects = true
			end,
		},
	},
	cmd = { "TSUpdateSync" },
	opts = {
		ensure_installed = require("config").ts_ensured_installed,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
			enable_rename = true,
			enable_close = true,
			enable_close_on_slash = true,
		},
	},
	config = function(M, opts)
		if type(opts.ensure_installed) == "table" then
			local added = {}
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end

		safe_plug_load("nvim-treesitter.configs", M).setup(opts)

		if load_textobjects then
			-- PERF: no need to load the plugin, if we only need its queries for mini.ai
			if opts.textobjects then
				for _, mod in ipairs { "move", "select", "swap", "lsp_interop" } do
					if opts.textobjects[mod] and opts.textobjects[mod].enable then
						local Loader = require "lazy.core.loader"
						Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
						local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
						require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
						break
					end
				end
			end
		end
	end,
}
