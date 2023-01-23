local M = {
  'glepnir/lspsaga.nvim'
}

function M.config()
  local saga = safe_plug_load('lspsaga')

  saga.init_lsp_saga({
    border_style = "rounded",
    finder_action_keys = {
      open = 'o',
      vsplit = 'v',
      split = 'h',
      quit = { 'q', 'e' },
      scroll_up = '<C-f>',
      scroll_down = '<C-d>',
    },
  })

  local map = require('utils.map')
  map.set('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>')
  map.set('n', ']d', ':Lspsaga diagnostic_jump_next<CR>')
  map.set('n', 'gh', ':Lspsaga hover_doc<CR>')
  map.set('n', 'gd', ':Lspsaga lsp_finder<CR>')
  map.set('n', 'gk', ':Lspsaga signature_help<CR>')
  map.set('n', 'gp', ':Lspsaga peek_definition<CR>')
  map.set('n', 'gr', ':Lspsaga rename<CR>')
  map.set('n', 'gl', ':Lspsaga show_line_diagnostics<CR>')
end

return M
