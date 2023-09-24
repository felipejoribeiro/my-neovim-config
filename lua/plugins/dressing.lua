require("core.utils")
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function ()
    require("dressing").setup({
      input = {
        enabled = true,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
    })
  end
}
