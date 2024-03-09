local cmdOffsetTop = 12
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    routes = {
      {
        -- avoid annoying message
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
    },
    cmdline = {
      enabled = true,
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = false,      -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,       -- add a border to hover docs and signature help
    },
    views = {
      cmdline_popup = {
        position = {
          row = cmdOffsetTop,
          col = "50%",
        },
        size = {
          width = 60,
          height = 1,
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = cmdOffsetTop + 3,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "NoiceNormal", FloatBorder = "NoiceFloatBorder" },
        },
      },
    },
  },
  config = function(M, opts)
    local noice = safe_plug_load("noice", M)
    noice.setup(opts)
  end
}
