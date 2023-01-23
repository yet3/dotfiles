local M = {
  'norcalli/nvim-colorizer.lua'
}

function M.config() 
  local colorizer = safe_plug_load('colorizer', M)

  colorizer.setup({
    '*'
  })
end

return M
