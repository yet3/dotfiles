local M = {
  'akinsho/toggleterm.nvim', 
  keys = { '<C-\\>' }
}

function M.config()
  local term = safe_plug_load('toggleterm', M)

  term.setup({
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = {
      border = "single",
    },
  })
end

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts, { desc = "Terminal: Close terminal while it's open" })
end

return M
