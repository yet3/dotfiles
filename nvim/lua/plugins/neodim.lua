return {
  enabled = false,
  "zbirenbaum/neodim",
  event = "LspAttach",
  branch = 'v2',
  opts = {},
  config = function(M, opts)
    local neodim = safe_plug_load("neodim", M)

    neodim.setup({
      refresh_delay = 75, -- time in ms to wait after typing before refresh diagnostics
      alpha = .75,
      blend_color = "#000000",
      hide = { underline = true, virtual_text = true, signs = true },
      disable = {}, -- table of filetypes to disable neodim
    })
  end
}
