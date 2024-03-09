local GitSigns = {
  'lewis6991/gitsigns.nvim',
  opts = {},
  config = function(M, opts)
    local signs = safe_plug_load('gitsigns', M)
    signs.setup(opts)
  end
}

local GitBlame = {
  'f-person/git-blame.nvim',
  opts = {
    display_virtual_text = 0
  },
  config = function(M, opts)
    local blame = safe_plug_load('gitblame', M)
    blame.setup(opts)
  end
}

return {
  GitSigns,
  GitBlame
}
