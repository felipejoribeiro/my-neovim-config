return {
  'felipejoribeiro/svgo.nvim',
  dependencies = { 'rcarriga/nvim-notify' },
  dir = '~/work/personal/svgo.nvim',
  keys = function()
    local svgo = require('svgo')
    return {
      {
        '<leader>is',
        function()
          svgo.create_and_open_svg()
        end,
        desc = 'Create and open a new SVG file with provided name.',
      },
      {
        '<leader>io',
        function()
          svgo.open_svg_under_cursor()
        end,
        desc = 'Open file under cursor (or file within environment under cursor).',
      },
    }
  end,
  opts = {
    illustration_dir = './data',
    relative_path = true,
    template_files = {
      directory = {
        svg = '~/notes/assets/templates/',
      },
      default = {
        svg = 'default.svg',
      },
    },
    text_templates = {
      svt = {
        md = '![%s](../s%)',
      },
    },
  },
}
