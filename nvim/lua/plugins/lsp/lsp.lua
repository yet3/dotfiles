local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
		{ "folke/neodev.nvim", opts = {} },
		"mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"b0o/schemastore.nvim",
	},

	opts = {
		diagnostics = {},
		inlay_hints = {
			enabled = false,
		},
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
	},
}

local function lsp_on_attach(callback)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			callback(client, buffer)
		end,
	})
end

function M.config(_, opts)
	-- plugin to manage global and project-local settings.
	-- init it BEFORE setting up servers
	if has_plugin "neoconf.nvim" then
		local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
		require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
	end

	local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
	lsp_on_attach(function(client, buffer)
		if inlay_hint and client.supports_method "textDocument/inlayHint" then
			inlay_hint.enable(buffer, true)
		end

		require("plugins.lsp.maps").set(client, buffer)
	end)

	local register_capability = vim.lsp.handlers["client/registerCapability"]

	vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
		local ret = register_capability(err, res, ctx)
		local client_id = ctx.client_id
		local client = vim.lsp.get_client_by_id(client_id)
		local buffer = vim.api.nvim_get_current_buf()
		require("plugins.lsp.maps").set(client, buffer)
		return ret
	end

	-- Diagnostics
	for name, icon in pairs(require("utils.ui.icons").diagnostics) do
		vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, texthl = name, numhl = "" })
	end

	vim.diagnostic.config {
		underline = true,
		update_in_insert = true,
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
			-- prefix = "icons",
		},
		severity_sort = true,
	}

	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	local mlsp = require "mason-lspconfig"

	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		has_cmp and cmp_nvim_lsp.default_capabilities() or {}
	)

	local lsp = require "lspconfig"

	mlsp.setup {
		handlers = {
			function(server_name)
				local server_opts = {
					capabilities = capabilities,
				}

				local config_status, config = pcall(require, "plugins.lsp.servers." .. server_name)
				if config_status and config.setup ~= nil then
					server_opts = vim.tbl_deep_extend("force", config.setup(M) or {}, server_opts)
				end

				lsp[server_name].setup(server_opts)
			end,
		},
	}
end

return M
