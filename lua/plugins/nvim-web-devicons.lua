return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      override = {
        txt = {
          icon = "𖣯",
          color = "#FFFFFF",
          cterm_color = "65",
          name = "Text",
        },
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
      },
      color_icons = true,
      default = true,
    })
  end,
}
