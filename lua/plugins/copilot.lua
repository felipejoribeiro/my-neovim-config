return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    -- load highlights
    LOAD_HIGHLIGHTS({
      CopilotSuggestion = { fg = '#CC88FF' },
    })

    require('copilot').setup({
      pannel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<a-k>',
          next = '<a-l>',
        },
      },
      filetypes = {
        ['dap-repl'] = false,
        ['dapui_watches'] = false,
      },
    })
  end,
}
