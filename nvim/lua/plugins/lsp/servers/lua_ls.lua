return {
  setup = function()
    return {
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          workspace = { checkThirdParty = false },
          completion = { callSnippet = "Replace" }
        }
      }
    }
  end
}
