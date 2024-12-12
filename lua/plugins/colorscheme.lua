require('core.utils')

return {
  'Mofiqul/dracula.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('dracula')

    -- load highlights
    LOAD_HIGHLIGHTS({
      CursorLine = { bg = 'none' },
      Normal = { bg = 'none' },
      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      FloatBackground = { bg = 'none' },
      Visual = { bg = '#6C76D7' },
      SignColumn = { link = 'LineNr' },
      DiffChange = { bg = '#533E0B' },
      DiffAdd = { bg = '#012522' },
      DiffDelete = { bg = '#290517' },
      DiffText = { bg = '#000000' },
    })
  end,
}
