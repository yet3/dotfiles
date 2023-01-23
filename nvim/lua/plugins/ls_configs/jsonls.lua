local M = {
  "jsonls"
}

function M.setup()
  local schemas = safe_plug_load('schemastore', M)

  return {
    settings = {
      json = {
        schemas = schemas.json.schemas(),
        validate = { enable = true },
      },
    }
  }
end

return M
