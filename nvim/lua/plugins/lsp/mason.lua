return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	lazy = false,
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_tools = require("mason-tool-installer")
		local mason_lspconf = require("mason-lspconfig")

		mason.setup({
			ui = {
				border = "single",
				backdrop = 100,
			},
		})
		mason_tools.setup({
			ensure_installed = {
				"eslint_d",
				"prettierd",
				"clang-format",
			},
		})

		mason_lspconf.setup({
			ensure_installed = {
				"angularls",
				"astro",
				"clangd",
				"cssls",
				"css_variables",
				"gopls",
				"harper_ls",
				"html",
				"jsonls",
				"lua_ls",
				"marksman",
				"rust_analyzer",
				"stylua",
				"svelte",
				"tailwindcss",
        "tsc",
				"unocss",
				"zls",
			},
		})
	end,
}
