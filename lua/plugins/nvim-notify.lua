return {
  'rcarriga/nvim-notify',
  version = '*',
  config = function()
    require('notify').setup({
      stages = 'fade',
      top_down = false,
      render = 'wrapped-compact',
    })
  end,
}
