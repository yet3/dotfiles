local M = {
  'romgrk/barbar.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' }
  }
}

function M.config()
  local bar = safe_plug_load('bufferline', M)

  bar.setup({
    animation = false,
    icons = true,
  })

  local map = require('utils.map')
  map.set('n', '<M-w>', ':BufferClose<CR>')
  map.set('n', '<M-W>', ':BufferClose!<CR>')
  map.set('n', '<M-h>', ':BufferPrevious<CR>')
  map.set('n', '<M-l>', ':BufferNext<CR>')
  map.set('n', '<M-1>', ':BufferGoto 1<CR>')
  map.set('n', '<M-2>', ':BufferGoto 2<CR>')
  map.set('n', '<M-3>', ':BufferGoto 3<CR>')
  map.set('n', '<M-4>', ':BufferGoto 4<CR>')
  map.set('n', '<M-5>', ':BufferGoto 5<CR>')
  map.set('n', '<M-6>', ':BufferGoto 6<CR>')
  map.set('n', '<M-7>', ':BufferGoto 7<CR>')
  map.set('n', '<M-8>', ':BufferGoto 8<CR>')
  map.set('n', '<M-9>', ':BufferGoto 9<CR>')
  map.set('n', '<M-0>', ':BufferLast<CR>')
end

return M
