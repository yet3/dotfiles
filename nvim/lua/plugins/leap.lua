local M = {
  'ggandor/leap.nvim'
}

function M.config()
  local leap = safe_plug_load('leap', M)

  local map = require('utils.map')
  map.set('n', 's', function()
    leap.leap { target_windows = { vim.fn.win_getid() } }
  end)

  map.set('n', 'gs', function()
    leap.leap { target_windows = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    ) }
  end)

  vim.cmd([[autocmd ColorScheme * lua require('leap').init_highlight(true)]])
end

return M
