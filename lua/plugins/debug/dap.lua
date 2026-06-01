return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    'microsoft/vscode-js-debug',
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    {
      'LiadOz/nvim-dap-repl-highlights',
      config = true,
    },
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
        local ok, err =
          pcall(require, 'plugins.debug.adapters.' .. vim.fn.fnamemodify(file, ':t:r'))
        if not ok then
          print('Error loading ' .. file .. ': ' .. err)
        end
      end
    end

    local ok, virtual_text = pcall(require, 'nvim-dap-virtual-text')
    if ok then
      virtual_text.setup({
        clear_on_continue = true,
        virt_text_pos = 'eol',
      })
    end

    vim.api.nvim_set_hl(0, 'NvimDapVirtualText', { fg = 'cyan' })
    vim.api.nvim_set_hl(0, 'NvimDapVirtualTextChanged', { fg = 'cyan' })

    vim.fn.sign_define(
      'DapBreakpoint',
      { text = '', texthl = 'cyan', linehl = '', numhl = 'cyan' }
    )
    vim.fn.sign_define(
      'DapStopped',
      { text = '▶', texthl = 'Green', linehl = 'ColorColumn', numhl = 'Green' }
    )
    vim.fn.sign_define(
      'DapBreakpointRejected',
      { text = '○', texthl = 'Comment', linehl = '', numhl = 'Comment' }
    )
    vim.fn.sign_define(
      'DapBreakpointCondition',
      { text = '◆', texthl = 'DiagnosticWarn', linehl = '', numhl = 'DiagnosticWarn' }
    )
    vim.fn.sign_define(
      'DapLogPoint',
      { text = '◆', texthl = 'DiagnosticInfo', linehl = '', numhl = 'DiagnosticInfo' }
    )

    -- INFO: Keymaps
    MAPKEY('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>', {})
    MAPKEY('n', '<leader>dc', ':lua require"dap".continue()<CR>', {})
    MAPKEY('n', '<leader>dj', ':lua require"dap".step_over()<CR>', {})
    MAPKEY('n', '<leader>dl', ':lua require"dap".step_into()<CR>', {})
    MAPKEY('n', '<leader>dh', ':lua require"dap".step_out()<CR>', {})
    MAPKEY('n', '<leader>dr', ':lua require"dap".repl.toggle()<CR>', {})
    MAPKEY('n', '<leader>dx', ':lua require"dap".disconnect()<CR>', {})
    MAPKEY('n', '<leader>dn', ':lua require"dap".run_to_cursor()<CR>', {})
  end,
}
