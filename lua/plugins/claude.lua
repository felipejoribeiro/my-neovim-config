return {
  dir = '~/work/personal/claude.vim',
  config = function()
    vim.g.claude_model = 'claude-3-5-sonnet-20241022'
    vim.g.claude_api_key = os.getenv('CLOUD_API_KEY')
    vim.g.claude_map_open_chat = '<leader>cv'
    vim.g.claude_map_implement = '<leader>cv'
    vim.g.claude_map_cancel_response = '<leader>cx'
  end,
}
