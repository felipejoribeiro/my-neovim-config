return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    branch = 'main',
    build = 'make tiktoken',
    config = function()
      local chat = require('CopilotChat')
      chat.setup({
        mappings = {
          reset = {
            normal = '<C-n>',
            insert = '<C-n>',
          },
        },
      })
      MAPKEY('n', '<leader>c', ':CopilotChatToggle<CR>', {})
    end,
  },
}
