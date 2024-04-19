return {
  'j-hui/fidget.nvim',
  tag = 'legacy',
  event = { 'BufEnter' },
  config = function()
    LOAD_HIGHLIGHTS({
      FidgetTitle = { fg = '#37FF25', ctermbg = 'none', bg = 'none' },
      FidgetTask = { fg = '#37FF25', ctermbg = 'none', bg = 'none' },
      FidgetProgress = { fg = '#37FF25', ctermbg = 'none', bg = 'none' },
    })
    require('fidget').setup({
      notificatin = {
        window = {
          normal_hl = 'FidgetProgress',
          border = 'rounded',
        },
      },
    })
  end,
}
