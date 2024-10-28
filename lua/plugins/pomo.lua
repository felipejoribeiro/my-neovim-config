return {
  'epwalsh/pomo.nvim',
  version = '*',
  dependencies = {
    'rcarriga/nvim-notify',
  },
  config = function()
    -- INFO: keymaps
    MAPKEY('n', '<Leader>T', ':TimerStart 30m<CR>', { silent = true })
    MAPKEY('n', '<Leader>Tt', ':TimerStart 15m<CR>', { silent = true })
    MAPKEY('n', '<Leader>Tp', ':TimerPause<CR>', { silent = true })
    MAPKEY('n', '<Leader>Tr', ':TimerResume<CR>', { silent = true })
    MAPKEY('n', '<Leader>Ts', ':TimerStop<CR>', { silent = true })

    -- load highlights
    local baseHl = {
      NotifyBackground = { bg = '#000000' },
    }
    LOAD_HIGHLIGHTS(baseHl)

    require('pomo').setup({
      update_interval = 1000,
    })
  end,
}
