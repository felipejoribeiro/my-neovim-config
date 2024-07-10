return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {
    bind = true,
    floating_window = false,
    floating_window_above_cur_line = true,
    floating_window_off_x = 20,
    transparency = 100,
    hint_enable = false,
    handler_opts = {
      border = 'rounded',
    },
    toggle_key = '<M-f>',
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}
