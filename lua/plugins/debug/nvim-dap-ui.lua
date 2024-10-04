return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dapui = require('dapui')
    dapui.setup({
      controls = {
        icons = {
          terminate = '',
        },
      },
    })

    MAPKEY('n', '<leader>du', '<Cmd>lua require("dapui").toggle()<CR>', {})
    MAPKEY('n', '<leader>dk', '<Cmd>lua require("dapui").eval()<CR>', {})
    MAPKEY('v', '<leader>dk', '<Cmd>lua require("dapui").eval()<CR>', {})
  end,
}
