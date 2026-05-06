return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"b0o/schemastore.nvim",
	},
	config = function()
		local og_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = "single"
			return og_util_open_floating_preview(contents, syntax, opts, ...)
		end

		vim.diagnostic.config({
			virtual_text = true,
			virtual_lines = false,
			float = {
				source = true,
			},
			-- virtual_lines = {
			-- 	current_line = true,
			-- },
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
				local map_opts = { buffer = bufnr }

				local client_id = args.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				if client and client.name == "svelte-ls" then
					vim.api.nvim_create_autocmd({ "BufWritePost" }, {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", {
								uri = ctx.match,
							})
						end,
					})
				end

				-- vim.lsp.document_color.enable(false, bufnr)
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
