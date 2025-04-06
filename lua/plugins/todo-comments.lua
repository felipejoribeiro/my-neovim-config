return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      comments_only = true,
    },
    keywords = {
      BUG = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'ISSUE' } },
      TODO = { icon = ' ', color = 'info' },
      HACK = { icon = ' ', color = '#f06caa' },
      WARN = { icon = ' ', color = '#ffb86c', alt = { 'WARNING', 'XXX' } },
      INFO = { icon = ' ', color = '#C0E8FF', alt = { 'INFO' } },
    },
  },
}
