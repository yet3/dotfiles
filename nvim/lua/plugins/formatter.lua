return {
	"stevearc/conform.nvim",
	dependencies = {
		"mfussenegger/nvim-lint",
	},
	config = function()
		local biome_prettier = { "biome", "prettierd", "prettier", stop_after_first = true }
		local prettier = { "prettierd", "prettier", stop_after_first = true }

		require("conform").setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },

				html = prettier,
				markdown = prettier,
				json = biome_prettier,

				css = biome_prettier,
				scss = biome_prettier,
				sass = biome_prettier,

				javascript = biome_prettier,
				typescript = biome_prettier,
				javascriptreact = biome_prettier,
				typescriptreact = biome_prettier,
			},
		})

		require("conform").formatters["biome"] = {
			args = { "check", "--stdin-file-path", "$FILENAME", "--write", "--unsafe" },
		}

		vim.keymap.set("n", "<leader>p", function()
			require("lint").try_lint()
			require("conform").format()
		end)
	end,
}
