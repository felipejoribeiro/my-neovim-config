return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  config = function()
    -- source all lua files in adapters folder
    local files_in_adapters = vim.fn.globpath(
      vim.fn.stdpath('config') .. '/lua/plugins/debug/adapters',
      '*.lua',
      false,
      true
    )
    for _, file in ipairs(files_in_adapters) do
      if file ~= nil then
        require('plugins.debug.adapters.' .. vim.fn.fnamemodify(file, ':t:r'))
      end
    end

    vim.fn.sign_define(
      'DapBreakpoint',
      { text = '⬢', texthl = 'cyan', linehl = '', numhl = 'cyan' }
    )
    vim.fn.sign_define(
      'DapStopped',
      { text = '▶', texthl = 'Green', linehl = 'ColorColumn', numhl = 'Green' }
    )

    -- INFO: Keymaps
    MAPKEY('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>', {})
    MAPKEY('n', '<leader>dc', ':lua require"dap".continue()<CR>', {})
    MAPKEY('n', '<leader>dj', ':lua require"dap".step_over()<CR>', {})
    MAPKEY('n', '<leader>di', ':lua require"dap".step_into()<CR>', {})
    MAPKEY('n', '<leader>do', ':lua require"dap".step_out()<CR>', {})
    MAPKEY('n', '<leader>dr', ':lua require"dap".repl.toggle()<CR>', {})
    MAPKEY('n', '<leader>dx', ':lua require"dap".disconnect()<CR>', {})
    MAPKEY('n', '<leader>dh', ':lua require"dap".run_to_cursor()<CR>', {})
  end,
}
