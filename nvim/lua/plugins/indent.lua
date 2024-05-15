return {
  {
    enabled = false,
    'nvimdev/indentmini.nvim',
    event = 'BufEnter',
    opts = {
      char = "|",
      exclude = {
        "erlang",
        "markdown",
      }
    },
    config = function(M, opts)
      local indent = safe_plug_load('indentmini', M)
      indent.setup(opts)
    end,
  },
  {
    enabled = true,
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { enabled = false },
    },
    setup = function(opts, M)
      local plug = safe_plug_load('ibl', M)
      plug.setup(opts)
    end
  }
}
