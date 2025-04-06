require('core.utils')
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    local git_signs = require('gitsigns')
    git_signs.setup()

    -- INFO: Keybindings
    MAPKEY('n', '<leader>gs', '<cmd>G<CR>')
    MAPKEY('n', '<leader>gb', '<cmd>Gitsigns blame<CR>')
    MAPKEY('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
    MAPKEY('n', '<leader>gl', '<cmd>Gitsigns toggle_current_line_blame<CR>')
  end,
}
