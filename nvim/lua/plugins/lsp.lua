return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",

		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		"j-hui/fidget.nvim",

		"saghen/blink.cmp",
		"b0o/SchemaStore.nvim",

		-- instead of tsserver
		"pmizio/typescript-tools.nvim",

		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
	},
	init = function()
		vim.g.coq_settings = {
			auto_start = "shut-up",
		}
	end,
	config = function()
		vim.diagnostic.config({
			underline = true,
			update_in_insert = true,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
		})

		local capabilities = nil
		if pcall(require, "blink.cmp") then
      capabilities = require("blink.cmp").get_lsp_capabilities()
    end

		local lspconfig = require("lspconfig")

		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})
		local mlc = require("mason-lspconfig")
		mlc.setup()

		local servers = {
			"html-lsp",
			"astro-language-server",
			"tailwindcss-language-server",
			"svelte-language-server",
			"css-lsp",
			"cssmodules-language-server",

			"lua-language-server",
			"rust-analyzer",
			"clangd",

			"json-lsp",
			"lemminx",
			"yaml-language-server",
			"taplo",

			"shfmt",

			"prettierd",
			"eslint_d",
			"stylua",

			"gopls",
		}
		require("mason-tool-installer").setup({
			ensure_installed = servers,
		})

		local border = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		}
		-- Set rounded border for lsp floats
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or border
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local config = {
					capabilities = capabilities,
				}
				local config_status, server_config = pcall(require, "plugins.lsp_servers_confs." .. server_name)
				if config_status and server_config.setup ~= nil then
					config = vim.tbl_deep_extend("force", server_config.setup() or {}, config)
				end
				lspconfig[server_name].setup(config)
			end,
		})

		-- Set up typescript
		require("typescript-tools").setup({})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			silent = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
				local map_opts = { buffer = bufnr }

				vim.keymap.set("n", "gp", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end)
				vim.keymap.set("n", "gn", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end)

				vim.keymap.set("n", "gh", vim.lsp.buf.hover, map_opts)
				vim.keymap.set("n", "go", vim.lsp.buf.definition, map_opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.declaration, map_opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, map_opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, map_opts)
				vim.keymap.set("n", "gl", function()
					vim.diagnostic.open_float(bufnr)
				end, map_opts)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, map_opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, map_opts)

				vim.keymap.set("n", "gs", function()
					vim.cmd("vsplit")
					vim.lsp.buf.definition()
				end, map_opts)
				vim.keymap.set("n", "gS", function()
					vim.cmd("split")
					vim.lsp.buf.definition()
				end, map_opts)
			end,
		})
	end,
}
