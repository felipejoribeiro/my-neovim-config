return {
  'martineausimon/nvim-lilypond-suite',
  config = function()
    require('nvls').setup({
      lilypond = {
        options = {
          pitches_language = 'default',
          hyphenation_language = 'en_DEFAULT',
          output = 'svg',
          backend = nil,
          main_file = 'main.ly',
          -- directory of current buffer
          main_folder = '%:p:h',
          include_dir = nil,
          diagnostics = false,
          pdf_viewer = 'zathura',
        },
      },
      texinfo = {
        mappings = {
          compile = '<leader>j',
          open_pdf = '<leader>J',
          lilypond_syntax = '<F3>',
        },
        options = {
          lilypond_book_flags = '--svg',
          clean_logs = false,
          main_file = 'main.texi',
          main_folder = '%:p:h',
          lilypond_syntax_au = 'BufEnter',
          pdf_viewer = 'zathura',
        },
      },
      player = {
        options = {
          fluidsynth_flags = {
            '/usr/share/soundfonts/FluidR3_GM.sf2',
          },
        },
      },
    })
  end,
}
