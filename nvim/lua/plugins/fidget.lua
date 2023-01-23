local M = {
  'j-hui/fidget.nvim'
}

function M.config()
  local fidget = safe_plug_load('fidget', M)
  fidget.setup({})
end

return M
