return {
  lsp = {
    inline_hints = false,
    diagnostics= {
      virtual_text = true
    }
  },
  ensured_installed = {
    -- 'typescript-language-server',
    'html-lsp',
    'astro-language-server',
    'tailwindcss-language-server',
    'svelte-language-server',
    'css-lsp',
    'cssmodules-language-server',

    'lua-language-server',
    'rust-analyzer',
    'clangd',

    'json-lsp',
    'lemminx',
    'yaml-language-server',

    'shfmt',

    'prettierd',
    'eslint_d',
    'stylua',
    
    'gopls',
  },
  ts_ensure_installed = {
    "bash",
    "html",
    "javascript",
    "typescript",
    "tsx",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "yaml",
    "rust",
    "vimdoc"
  },
}
