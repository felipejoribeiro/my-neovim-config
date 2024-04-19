return {
  'gelguy/wilder.nvim',
  keys = {
    ':',
    '/',
    '?',
  },
  config = function()
    local wilder = require('wilder')

    wilder.setup({
      modes = { ':', '/', '?' },
      next_key = '<Tab>',
      prev_key = '<S-Tab>',
      accept_key = '<CR>',
      reject_key = '<Esc>',
    })

    wilder.set_option(
      'renderer',
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        highlights = {
          border = 'Normal',
        },
        border = 'rounded',
      }))
    )
    local gradient = {
      '#f4468f',
      '#fd4a85',
      '#ff507a',
      '#ff566f',
      '#ff5e63',
      '#ff6658',
      '#ff704e',
      '#ff7a45',
      '#ff843d',
      '#ff9036',
      '#f89b31',
      '#efa72f',
      '#e6b32e',
      '#dcbe30',
      '#d2c934',
      '#c8d43a',
      '#bfde43',
      '#b6e84e',
      '#aff05b',
    }

    for i, fg in ipairs(gradient) do
      gradient[i] = wilder.make_hl(
        'WilderGradient' .. i,
        'Pmenu',
        { { a = 1 }, { a = 1 }, { foreground = fg } }
      )
    end

    wilder.set_option(
      'renderer',
      wilder.popupmenu_renderer({
        highlights = {
          gradient = gradient,
        },
        highlighter = wilder.highlighter_with_gradient({
          wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
        }),
      })
    )
    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.cmdline_pipeline({
          language = 'python',
          fuzzy = 1,
        }),
        wilder.python_search_pipeline({
          pattern = wilder.python_fuzzy_pattern(),
          sorter = wilder.python_difflib_sorter(),
          engine = 're',
        })
      ),
    })
  end,
}
