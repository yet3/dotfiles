return {
  "nvimdev/guard.nvim",
  -- Builtin configuration, optional
  dependencies = {
    "nvimdev/guard-collection",
  },
  config = function(M)
    local ft = safe_plug_load('guard.filetype', M)

    ft('lua'):fmt('lsp')
        :append('stylua')
    -- :lint('selene')

    ft('typescript,javascript,typescriptreact,javascriptreact,svelte'):fmt('prettier'):lint('eslint_d')
    ft('go'):fmt('gofmt')

    -- ft('*'):lint('codespell')
    -- ft('go'):fmt('gofmt'):lint('golangci_lint')

    -- Call setup() LAST!
    local guard = safe_plug_load('guard', M)
    guard.setup({
      -- the only options for the setup function
      fmt_on_save = false,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
    })
  end
}
