return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		local has_config_file = require("lib.has-config-file")
		local lint = require("lint")

		local use_biome = has_config_file({ "biome.json", "biome.jsonc" })
		local use_eslint = has_config_file({ "eslint.config.js", ".eslintrc", ".eslintrc.json", ".eslintrc.js" })

		local biome_prettier = {
			use_biome and "biomejs" or use_eslint and "eslint_d" or "biomejs",
			"codespell",
		}

		lint.linters_by_ft = {
			lua = { "codespell" },
			--
			javascript = biome_prettier,
			typescript = biome_prettier,
			javascriptreact = biome_prettier,
			typescriptreact = biome_prettier,
			css = biome_prettier,
			scss = biome_prettier,
			sass = biome_prettier,
		}

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
