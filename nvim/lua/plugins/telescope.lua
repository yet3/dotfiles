local open_with_picker = function(prompt_bufnr)
  local action_state = require('telescope.actions.state')

  local cur_picker = action_state.get_current_picker(prompt_bufnr)
  cur_picker.get_selection_window = function(picker, entry)
    local picked_window_id = require('window-picker').pick_window({
      filter_rules = {
        include_current_win = true,
      }
    }) or vim.api.nvim_get_current_win()
    picker.get_selection_window = nil
    return picked_window_id
  end

  return prompt_bufnr
end

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    's1n7ax/nvim-window-picker'
  },
  config = function(M)
    local telescope = safe_plug_load('telescope', M)
    local actions = safe_plug_load('telescope.actions', M)
    local action_set = require('telescope.actions.set')
    local builtin = safe_plug_load('telescope.builtin', M)

    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values

    -- local colors = function(opts)
    --   opts = opts or {}
    --   opts = require("telescope.themes").get_dropdown {}
    --   -- vim.notify(vim.inspect(opts))
    --   pickers.new(opts, {
    --     prompt_title = "colors",
    --     finder = finders.new_table {
    --       results = {
    --         { "red",   "#ff0000" },
    --         { "green", "#00ff00" },
    --         { "blue",  "#0000ff" },
    --       },
    --       entry_maker = function(entry)
    --         return {
    --           value = entry,
    --           display = entry[1],
    --           ordinal = entry[1],
    --         }
    --       end
    --     },
    --     sorter = conf.generic_sorter(opts),
    --   }):find()
    -- end
    --
    -- map("n", "zm", colors)

    telescope.setup({
      defaults = {
        prompt_prefix="  ",
        file_ignore_patterns = { '%.git', 'cache', 'node_modules' },
        path_display = { 'truncate' },
        mappings = {
          n = {
            ['<C-e>'] = actions.close,

            ['s'] = function(prompt_bufnr)
              return action_set.edit(open_with_picker(prompt_bufnr), 'vnew')
            end,
            ['S'] = function(prompt_bufnr)
              return action_set.edit(open_with_picker(prompt_bufnr), 'new')
            end,
            -- ['<CR>'] = function(prompt_bufnr)
            --   return action_set.edit(open_with_picker(prompt_bufnr), 'edit')
            -- end,
            -- ['o'] = function(prompt_bufnr)
            --   return action_set.edit(open_with_picker(prompt_bufnr), 'edit')
            -- end,
            ['w'] = function(prompt_bufnr)
              return action_set.edit(open_with_picker(prompt_bufnr), 'edit')
            end,
            ['<CR>'] = actions.select_default,
            ['o'] = actions.select_default
          },
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,

            ['<C-e>'] = actions.close,
            -- ['<CR>'] = function(prompt_bufnr)
            --   return action_set.edit(open_with_picker(prompt_bufnr), 'edit')
            -- end,
            ['<C-w>'] = function(prompt_bufnr)
              return action_set.edit(open_with_picker(prompt_bufnr), 'edit')
            end,
            ['<CR>'] = actions.select_default,
            ['<C-s>'] = function(prompt_bufnr)
              return action_set.edit(open_with_picker(prompt_bufnr), 'vnew')
            end,
            ['<C-S>'] = function(prompt_bufnr)
              return action_set.edit(open_with_picker(prompt_bufnr), 'new')
            end,
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = 'smart_case',       -- or 'ignore_case' or 'respect_case'
          -- the default case_mode is 'smart_case'
        }
      }
    })

    telescope.load_extension('fzf')
    map('n', '<leader>ff', ':Telescope find_files hidden=true<CR>', { desc = 'Telescope: find file' })
    map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: find in files (live_grep)' })
    map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: find buffer' })
    map('n', '<leader>fh', ':Telescope diagnostics<CR>', { desc = 'Telescope: search diagnostics' })
    map('n', '<leader>f.', ':Telescope resume<CR>', { desc = 'Telescope: resume' })
    map('n', '<leader>f/', ':Telescope pickers<CR>', { desc = 'Telescope: pickers' })
  end
}
