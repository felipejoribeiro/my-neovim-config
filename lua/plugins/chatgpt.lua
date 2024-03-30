return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('chatgpt').setup({
      chat = {
        question_sign = '👀',
        answer_sign = '🤖',
        keymaps = {
          close = '<C-c>',
        },
      },
    })
  end,
}
