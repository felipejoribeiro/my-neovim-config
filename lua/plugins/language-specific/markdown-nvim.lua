return {
  'tadmccorkle/markdown.nvim',
  ft = 'markdown',
  config = function()
    local on_attach = function(bufnr)
      MAPKEYBUF(bufnr, 'i', '<M-l><M-o>', '<Cmd>MDListItemBelow<CR>', {})
      MAPKEYBUF(bufnr, 'i', '<M-L><M-O>', '<Cmd>MDListItemAbove<CR>', {})
      MAPKEYBUF(bufnr, 'n', '<M-c>', '<Cmd>MDTaskToggle<CR>', {})
    end

    require('markdown').setup({
      on_attach = function(bufnr)
        on_attach(bufnr)
      end,
    })
  end,
}
