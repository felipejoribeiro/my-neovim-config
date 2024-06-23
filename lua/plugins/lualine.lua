return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require('lualine')

    lualine.setup({
      sections = {
        lualine_b = {
          { 'branch', icon = '' },
        },
        lualine_c = {
          { 'filename', file_status = true, path = 4 },
        },
        lualine_x = {
          { 'encoding' },
        },
      },
    })
  end,
}
