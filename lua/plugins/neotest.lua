return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-python',
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    MAPKEY('n', '<Leader>tm', "<cmd>lua require('neotest').run.run()<cr>", { silent = true })
    MAPKEY(
      'n',
      '<Leader>tM',
      "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
      { silent = true }
    )
    MAPKEY(
      'n',
      '<Leader>tc',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
      { silent = true }
    )
    MAPKEY(
      'n',
      '<Leader>tC',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      { silent = true }
    )
    MAPKEY(
      'n',
      '<Leader>tf',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
      { silent = true }
    )
    MAPKEY(
      'n',
      '<Leader>tF',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      { silent = true }
    )
    MAPKEY('n', '<Leader>ts', "<cmd>lua require('neotest').summary.toggle()<cr>", { silent = true })

    require('neotest').setup({
      adapters = {
        require('neotest-python')({
          dap = {
            justMyCode = true,
            console = 'integratedTerminal',
          },
          args = { '--log-level', 'DEBUG', '--quiet' },
          runner = 'pytest',
        }),
      },
    })
  end,
}
