local M = {
	'nvim-telescope/telescope.nvim', 
	branch = '0.1.x',
	dependencies = {
		{'nvim-lua/plenary.nvim'},
		{'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	cmd = { "Telescope", "Tel" }, -- lazy loads on these commands
	keys = { "<leader>f" }, -- lazy loads on this pattern
}

function M.config()
	local telescope = safe_plug_load("telescope", M)
  local actions = require('telescope.actions')

	telescope.setup({
    defaults = {
        file_ignore_patterns = { '%.git', 'cache', 'node_modules' },
        path_display = { 'truncate' },
        mappings = {
          n = {
            ['e'] = actions.close,
            ['q'] = actions.close,
            ['o'] = actions.select_default,
            ['v'] = actions.file_vsplit,
            ['h'] = actions.file_split
          },
          i = {
            ['<C-q>'] = actions.close,
            ['<C-e>'] = actions.close,
            ['<C-v>'] = actions.file_vsplit,
            ['<C-h>'] = actions.file_split
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
                                           -- the default case_mode is 'smart_case'
        }
      }
  })

  telescope.load_extension('fzf')

	local map = require("utils.map")
	local builtin = require('telescope.builtin')
	map.set('n', '<leader>ff', ':Telescope find_files hidden=true<CR>', { desc = 'Telescope: find file' })
	map.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: find in files (live_grep)' })
	map.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: find buffer' })
	map.set('n', '<leader>fh', ':Telescope diagnostics<CR>', { desc = 'Telescope: search diagnostics' })
end

return M
