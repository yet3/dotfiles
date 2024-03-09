local M = {}

function M.set(_, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }

  map("n", "go", vim.lsp.buf.definition, opts)
  map("n", "gs", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end, opts)
  map("n", "gS", function()
    vim.cmd("split")
    vim.lsp.buf.definition()
  end, opts)


  map("n", "<LEADER>p", ':GuardFmt<CR>', opts)
end

return M
