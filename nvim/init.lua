-- placeholder till nvim-notify loads
vim.notify = function()
end

require('utils')
require('core')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_state = vim.fn.stdpath("state") .. "/lazy/state.json"

vim.notify(lazypath)
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins', {
  state = lazy_state,
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true,        -- get a notification when new updates are found
    frequency = 3600,     -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
})
