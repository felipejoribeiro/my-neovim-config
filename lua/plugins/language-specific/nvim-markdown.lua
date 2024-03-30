return {
  'ixru/nvim-markdown',
  ft = { 'markdown' },
  config = function()
    -- INFO: nvim conceal settings
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_conceal = 2

    -- add vim code block bellow
    vim.cmd([[
      imap <Plug> <Plug>Markdown_CreateLink
    ]])
  end,
}
