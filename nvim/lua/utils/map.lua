function _G.map(m, l, r, o)
  local opts = { silent = true, noremap = true }
  if o then
    opts = vim.tbl_deep_extend('force', opts, o)
  end

  vim.keymap.set(m, l, r, opts)
end

