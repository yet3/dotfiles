local M = {
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000,
}

function M.config()
  local t = safe_plug_load('rose-pine', M)
  t.setup({
    highlight_groups = {
      NormalFloat = { bg = 'base' },
      LspFloatWinNormal = { bg = 'base' },
      LspFloatWinBorder = { bg = 'base' },
      Pmenu = { bg = 'base' },
      CmpBorder = { bg = 'base' }
    }
  })
  vim.cmd('colorscheme rose-pine')
end

return M
