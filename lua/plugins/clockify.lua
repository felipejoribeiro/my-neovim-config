return {
  'felipejoribeiro/clockify.nvim',
  dir = '~/work/personal/clockify.nvim',
  config = function()
    require('clockify').setup({
      debug = true,
    })
    MAPKEY(
      'n',
      '<leader>cl',
      '<cmd>lua require("clockify").notify_i_am_working()<CR>',
      { noremap = true, silent = true }
    )
  end,
}
