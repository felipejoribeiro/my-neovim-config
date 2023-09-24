require("core.utils")
return {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPre", "BufNewFile" },
  build = { ":TSUpdate" },
  dependencies = { "windwp/nvim-ts-autotag" },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = {
        "yaml",
        "html",
        "css",
        "lua",
        "python",
        "markdown",
        "markdown_inline",
        "javascript",
        "json",
        "typescript",
        "tsx",
        "svelte",
        "graphql",
        "bash",
        "dockerfile",
        "gitignore",
        "vim",
        "vimdoc",
        "query",
      },
      auto_install = true,
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
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    })
  end
}
