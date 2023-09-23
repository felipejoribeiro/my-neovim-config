-- pluggins configuration
-- Author: @felipejoribeiro

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

-- safe loading lazy.nvim
local ok, lazy = pcall(require, "lazy")
if ok then
lazy.setup({
  {import = "plugins"},
  {import = "plugins.lsp"},
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  }
})
end
