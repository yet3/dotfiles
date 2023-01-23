local M = {
  'rcarriga/nvim-notify',
  priority = 1001,
}

function M.config()
  local status, notify = pcall(require, 'notify')
  if (not status) then
    print('Error while loading plugin: nvim-notify')
    return
  end
  vim.notify = notify
end

return M
