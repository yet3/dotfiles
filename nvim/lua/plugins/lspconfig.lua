local M = {
  'williamboman/mason.nvim',
  dependencies = {
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'jose-elias-alvarez/null-ls.nvim'},
    {'b0o/schemastore.nvim'}
  }
}

function M.config()
  local mason = safe_plug_load('mason', M)
  mason.setup()

  local lsp = safe_plug_load('lspconfig', M)
  local mason_lsp = safe_plug_load('mason-lspconfig', M)

  local protocol = require('vim.lsp.protocol')

  local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.keymap.set("n", "go", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gv", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, opts)

    vim.keymap.set("n", "<LEADER>p", vim.lsp.buf.format, opts)
  end

  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }

  local capabilities = safe_plug_load('cmp_nvim_lsp', M).default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )


  mason_lsp.setup({
    ensure_installed = { 'sumneko_lua', 'tsserver', 'tailwindcss', 'cssls', 'jsonls', 'html', 'marksman', 'astro', 'volar',
      'lemminx', 'yamlls', 'taplo' }
  })

  local servers = mason_lsp.get_installed_servers()
  for _, name in pairs(servers) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    local config_status, config = pcall(require, 'plugins.ls_configs.' .. name)
    if (config_status) then
      opts = vim.tbl_deep_extend('force', config.setup() or {}, opts)
    end

    lsp[name].setup(opts)
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  }
  )

  -- Diagnostic symbols in the sign column (gutter)
  local symbols = require('utils.ui.symbols')
  local signs = {
    Error = symbols.space_after.error,
    Warn = symbols.space_after.warn,
    Hint = symbols.space_after.hint,
    Info = symbols.space_after.info
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = {
      prefix = '●'
    },
    update_in_insert = true,
    float = {
      source = "always", -- Or "if_many"
    },
  })

  -- null-ls
  local nls = safe_plug_load('null-ls', M)
  local formatting = nls.builtins.formatting
  local diagnostics = nls.builtins.formatting

  nls.setup({
    debug = false,
    sources = {
      -- formatters
      formatting.prettierd,
      --[[ formatting.stylua, ]]

      -- linters
      diagnostics.eslint_d,
    },
  })
end

return M
