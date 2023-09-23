require("core.utils")
return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local status, treessiterConf = pcall(require, "nvim-treesitter.configs")
    if not status then
      return
    end

    treessiterConf.setup({
      ensure_installed = { "lua", "python", "javascript" },
      highlight = {
        enable = true,
        disable = { "" },
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    })
  end
}
