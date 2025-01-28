return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			lua = { "codespell" },

			javascript = { "biomejs", "codespell" },
			typescript = { "biomejs", "codespell" },
			javascriptreact = { "biomejs", "codespell" },
			typescriptreact = { "biomejs", "codespell" },

			css = { "biomejs", "codespell" },
			scss = { "biomejs", "codespell" },
			sass = { "biomejs", "codespell" },
		}

		local debouncedLint = debounce(function()
			require("lint").try_lint()
		end, 250)

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})

		vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP" }, {
			callback = function()
				debouncedLint()
			end,
		})
	end,
}
