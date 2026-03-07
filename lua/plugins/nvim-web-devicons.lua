return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    require('nvim-web-devicons').setup({
      override = {
        tscn = {
          icon = '',
          color = '#519ABA',
          cterm_color = '65',
          name = 'Tscn',
        },
        gd = {
          icon = '',
          color = '#ABE839',
          cterm_color = '136',
          name = 'Godot',
        },
        txt = {
          icon = '',
          color = '#FFFFFF',
          cterm_color = '65',
          name = 'Text',
        },
        zsh = {
          icon = '',
          color = '#428850',
          cterm_color = '65',
          name = 'Zsh',
        },
      },
      color_icons = true,
      default = true,
    })
  end,
}
