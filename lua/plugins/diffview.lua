return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    MAPKEY('n', '<leader>vd', '<cmd>DiffviewOpen dev<CR>')
    MAPKEY('n', '<leader>vh', '<cmd>DiffviewOpen HEAD~1<CR>')
    MAPKEY('n', '<leader>vv', '<cmd>DiffviewToggle<CR>')
    MAPKEY('n', '<leader>vc', '<cmd>DiffviewClose<CR>')
    MAPKEY('v', '<leader>v', '<cmd>DiffviewFileHistory<CR>')
  end,
}
