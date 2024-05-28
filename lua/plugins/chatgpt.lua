return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  config = function()
    MAPKEY('n', '<leader>c', ':ChatGPT<CR>', {})
    MAPKEY('n', '<leader>cc', ':ChatGPTCompleteCode<CR>', {})
    MAPKEY('n', '<leader>ce', ':ChatGPTEditWithInstructions<CR>', {})
    MAPKEY('v', '<leader>ce', ':ChatGPTEditWithInstructions<CR>', {})
    require('chatgpt').setup()
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
