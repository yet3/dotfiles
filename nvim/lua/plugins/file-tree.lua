return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    's1n7ax/nvim-window-picker'
  },
  opts = {
    popup_border_style = "rounded",
    use_default_mappings = false,
    window = {
      popup = {
        position = { col = '50%', row = '30%' }
      },
      position = "float",
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false
        },
        ["o"] = {
          "open_with_window_picker",
          nowait = true
        },
        ["<cr>"] = "open",

        ["<esc>"] = "cancel", -- close preview or floating neo-tree window

        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["l"] = "focus_preview",

        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",

        ["C"] = "close_node",
        ["z"] = "close_all_nodes",

        ["a"] = {
          "add",
          -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "relative" -- "none", "relative", "absolute"
          },
        },

        ["/"] = "fuzzy_finder",

        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["i"] = "show_file_details",

        ["H"] = "toggle_hidden",

        ["E"] = function(state)
          local path = state.tree:get_node().path
          vim.fn.system { "open", vim.fn.fnameescape(path) }
          require("neo-tree.sources.manager").refresh(state.name)
        end
      }
    },
    filesystem = {
      commands = {
        delete = function(state)
          local inputs = require("neo-tree.ui.inputs")
          local path = state.tree:get_node().path
          local msg = "Are you sure you want to delete " .. path
          inputs.confirm(msg, function(confirmed)
            if not confirmed then return end

            vim.fn.system { "trash", vim.fn.fnameescape(path) }
            require("neo-tree.sources.manager").refresh(state.name)
          end)
        end,
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,

        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
          }
        }
      }
    },
    default_component_configs = {
      modified = {
        symbol = "",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = " ",
          modified  = " ",
          deleted   = " ",
          renamed   = "󰁕",
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
    }
  },
  config = function(M, opts)
    local tree = safe_plug_load('neo-tree', M)
    tree.setup(opts)
  end
}
