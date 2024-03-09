local setUpTermMaps = function(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "t", [[<c-\>]], "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "t", "<c-q>", "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "t", "<c-e>", "<cmd>close<CR>", { noremap = true, silent = true })
end

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    open_mapping = [[<leader>tt]],
    direction = 'float',
    insert_mappings = false,
    on_open = function(term)
      vim.cmd("startinsert!")
      setUpTermMaps(term.bufnr)
    end,
    float_opts = {
      border = 'curved',
      winblend = 3,
      title_pos = 'center'
    },
  },
  config = function(M, opts)
    local t = safe_plug_load('toggleterm', M)
    t.setup(opts)
    local Terminal = require('toggleterm.terminal').Terminal
    local mconfig = require('core.mconfig')

    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = 'float',
      on_open = function(term)
        vim.cmd("startinsert!")
        setUpTermMaps(term.bufnr)
      end,
    })

    local lazygit_toggle = function()
      lazygit:toggle()
    end

    map("n", "<leader>tg", lazygit_toggle, { noremap = true, silent = true })

    local runner = Terminal:new({
      direction = 'float',
    })

    local compiler = Terminal:new({
      direction = 'float',
      on_open = function(term)
        vim.cmd("startinsert!")
        setUpTermMaps(term.bufnr)
      end,
    })

    local has_run_run = false
    local has_run_compile = false
    local toggleRunnerCompiler = function(action)
      local def_root_dir = vim.fn.getcwd()

      local terms_confs = mconfig:get_config().projects or {}


      local root_dir = nil
      local run_cmd = nil
      local compile_cmd = nil

      for k, v in pairs(terms_confs) do
        if v.project_root_dir == def_root_dir then
          root_dir = v.project_root_dir

          if v.run then
            run_cmd = v.run.cmd
            if run_cmd == nil or #run_cmd == 0 then
              run_cmd = nil
            end
          end

          if v.compile then
            compile_cmd = v.compile.cmd
            if compile_cmd == nil or #compile_cmd == 0 then
              compile_cmd = nil
            end
          end

          break
        end
      end

      vim.print(root_dir)


      if root_dir == nil or (not run_cmd and action == 'run') or (not compile_cmd and action == 'compile') then
        mconfig:save_project({
          project_root_dir = root_dir or vim.fn.input("Dir:", def_root_dir, "file"),
          run = action == 'run' and (not run_cmd) and { cmd = vim.fn.input("Run cmd:", '') } or { cmd = run_cmd },
          compile = action == 'compile' and (not compile_cmd) and { cmd = vim.fn.input("Compile cmd:", '') } or
              { cmd = compile_cmd }
        })
      else
        if action == 'run' then
          runner.on_open = function(term)
            vim.cmd("startinsert!")
            setUpTermMaps(term.bufnr)
            require('toggleterm').exec(run_cmd or '', term.bufnr, 12)
          end
          runner:open()
        else
          local term = compiler:toggle()
          if not has_run_compile then
            has_run_compile = true
            require('toggleterm').exec(compile_cmd or '', term.bufnr, 12)
          end
        end
      end
    end

    map("n", "<leader>tr", function()
      toggleRunnerCompiler('run')
    end, { noremap = true, silent = true })
    map("n", "<leader>tc", function()
      toggleRunnerCompiler('compile')
    end, { noremap = true, silent = true })
  end
}
