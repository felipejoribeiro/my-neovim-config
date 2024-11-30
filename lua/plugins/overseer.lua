return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup()

    MAPKEY('n', '<leader>o', '<cmd>OverseerToggle<cr>')
    MAPKEY('n', '<leader>or', '<cmd>OverseerRun<cr>')
  end,
}
