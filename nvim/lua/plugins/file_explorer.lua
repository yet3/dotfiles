local M = {
    'kyazdani42/nvim-tree.lua',
    tag = 'nightly',
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' }
    },
    keys = { '<leader>m', '<leader>n', '<C-n>' }
}

function M.config()
  local tree = safe_plug_load('nvim-tree', M)
  local symbols = require('utils.ui.symbols')

  tree.setup({
      view = {
          side = 'right',
          adaptive_size = true,
          width = 40,
          mappings = {
              list = {
                  { key = "v", action = "vsplit" },
                  { key = "h", action = "split" },
              },
          },
      },
      notify = {
          threshold = vim.log.levels.WARN,
      },
      renderer = {
          group_empty = true,
      },
      filters = {
          dotfiles = true,
      },
      diagnostics = {
          enable = true,
          show_on_dirs = false,
          icons = {
              hint = symbols.hint,
              info = symbols.info,
              warning = symbols.warn,
              error = symbols.error
          }
      }
  })

  local map = require('utils.map')
  map.set('n', '<leader>m', ':NvimTreeFindFile<CR>')
  map.set('n', '<leader>n', ':NvimTreeToggle<CR>')
  map.set('n', '<C-n>', ':NvimTreeFocus<CR>')
end

return M
