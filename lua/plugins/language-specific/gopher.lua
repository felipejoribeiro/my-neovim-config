return {
  'olexsmir/gopher.nvim',
  ft = 'go',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'mfussenegger/nvim-dap',
  },
  config = function(_, opts)
    require('gopher').setup(opts)
  end,
}
