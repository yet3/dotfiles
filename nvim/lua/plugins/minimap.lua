local M = {
  'wfxr/minimap.vim',
  build = '!cargo install --locked code-minimap',
  enabled = false
}

function M.config() 
  vim.cmd([[
    let g:minimap_width = 10
    let g:minimap_auto_start = 1
    let g:minimap_auto_start_win_enter = 1

    let g:minimap_highlight_search = 1
    let g:minimap_git_colors = 1
    let g:minimap_highlight_range = 1
  ]])
end

return M
