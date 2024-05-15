return {
  "nvimdev/guard.nvim",
  -- Builtin configuration, optional
  dependencies = {
    "nvimdev/guard-collection",
  },
  config = function(M)
    local ft = safe_plug_load('guard.filetype', M)

    ft('lua'):fmt('stylua')

    ft('typescript,javascript,typescriptreact,javascriptreact,svelte'):fmt('prettier'):lint('eslint_d')
    ft('css,scss,sass'):fmt('prettier')
    ft('go'):fmt('gofmt')

    ft('json'):fmt('prettier')
    ft('html'):fmt('prettier')
    -- ft('*'):lint('codespell')
    -- ft('go'):fmt('gofmt'):lint('golangci_lint')
    -- Call setup() LAST!

    local guard = safe_plug_load('guard', M)
    guard.setup({
      fmt_on_save = false,
      lsp_as_default_formatter = true,
    })
  end
}
