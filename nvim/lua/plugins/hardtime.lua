return {
  "m4xshen/hardtime.nvim",
  enabled = false,
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {},
  config = function(M, opts) 
  safe_plug_load("hardtime", M).setup(opts)
  end
}

