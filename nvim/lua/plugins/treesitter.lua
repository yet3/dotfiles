local M = {
  'nvim-treesitter/nvim-treesitter', 
  build = ':TSUpdate',
  dependencies = {
    {'windwp/nvim-autopairs'},
    {'windwp/nvim-ts-autotag'},
    {'JoosepAlviste/nvim-ts-context-commentstring'}
  }
}

function M.config()
  local ts = safe_plug_load('nvim-treesitter.configs', M)

  ts.setup({
    ensure_installed = {
      'tsx', 'lua', 'json', 'css', 'astro', 'rust'
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false
    }
  })
end

return M
