local json = require "json"

local M = {
  has_loaded = false,
  config = {
    projects = {}
  }
}

function M:get_config()
  if not M.has_loaded then
    M:load()
  end
  return M.config
end

local C_PATH = '/Users/anty3/.config/nvim/m-projects.json'

function M:load()
  local file = io.open(C_PATH, "r")

  if file then
    local text = file:read("*a")
    M = vim.tbl_deep_extend('force', M, {
      has_loaded = true,
      config = json.decode(#text == 0 and "{}" or text) or {}
    })
    file:close()
  end
end

function M:save_project(pro)
  if not M.has_loaded then
    M:load()
  end

  local file = io.open(C_PATH, "w")
  if file then
    vim.print(json.encode(M.config.projects))
    table.insert(M.config.projects, pro)
    file:write(json.encode(M.config))
    file:close()
    M:load()
  end
end

M:load()

return M
