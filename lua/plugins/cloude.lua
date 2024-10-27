return {
  dir = '~/work/personal/claude.vim',
  config = function()
    vim.g.claude_model = 'claude-3-5-sonnet-20241022'
    vim.g.claude_api_key = os.getenv('CLOUD_API_KEY')
    vim.g.claude_open_chat_keybinding = '<leader>cv'
    vim.g.claude_implement_keybinding = '<leader>cv'
    vim.g.claude_cancel_response_keybinding = '<leader>cx'
  end,
}
