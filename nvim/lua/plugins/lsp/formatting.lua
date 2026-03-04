return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>p",
			function()
				local conform = require("conform")

				local ok, lint = pcall(require, "lint")
				if ok then
					lint.try_lint()
				end

				conform.format()
			end,
			mode = { "n", "v" },
		},
	},
	config = function()
		local conform = require("conform")

		local biome_prettier = { "biome", "prettier", stop_after_first = true }
		local prettier = { "prettier", stop_after_first = true }

		conform.setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				--
				html = biome_prettier,
				markdown = prettier,
				--
				astro = biome_prettier,
				--
				json = biome_prettier,
				jsonc = biome_prettier,
				css = biome_prettier,
				scss = biome_prettier,
				sass = biome_prettier,
				javascript = biome_prettier,
				typescript = biome_prettier,
				javascriptreact = biome_prettier,
				typescriptreact = biome_prettier,
			},
		})

		conform.formatters["biome"] = {
			args = { "check", "--stdin-file-path", "$FILENAME", "--write", "--unsafe" },
			require_cwd = true,
		}
	end,
}
