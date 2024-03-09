return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },
  {"fladson/vim-kitty"},
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    opts = {
      hint = 'floating-big-letter',
      show_prompt = false,
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
          filetype = { "NvimTree", 'neo-tree', "neo-tree-popup", "notify", "fidget" },
          buftype = { 'terminal', "quickfix", "nofile" },
        },
      }
    },
    config = function(M, opts)
      safe_plug_load('window-picker', M).setup(opts)
    end,
  }
}
