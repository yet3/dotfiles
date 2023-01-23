local M = {
  'nvim-lualine/lualine.nvim'
}

function M.config() 
  local lualine = safe_plug_load('lualine', M)
  local symbols = require('utils.ui.symbols')

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
      lualine_b = { 'branch' },
      lualine_c = { {
        'filename',
        file_status = true,
        newfile_status = true,
        path = 1,
      } },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = symbols.space_after
        },
        'encoding',
        'filetype'
      },
     --[[ lualine_y = {
        {
          require("noice").api.status.message.get_hl,
          cond = require("noice").api.status.message.has,
        },
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#ff9e64" },
        },
      },]]--
      lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { {
        'filename',
        file_status = true,
        newfile_status = true,
        path = 1,
      } },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {}
  })
end

return M
