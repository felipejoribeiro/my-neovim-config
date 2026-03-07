return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      csharp = { 'sonarlint-language-server' },
      go = { 'golangci-lint' },
      make = { 'checkmake' },
      gdscript = { 'gdlint' },
    }

    local sqlfluff = require('lint').linters.sqlfluff
    sqlfluff.args = {
      'lint',
      '--format=json',
      '--dialect=postgres',
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
      pattern = {
        '*.py',
        'Makefile',
      },
      group = lint_augroup,
      callback = function()
        require('core.lsp_identifiers')

        if vim.bo.filetype == 'python' then
          if CHECK_RUFF() == true then
            lint.try_lint('ruff')
          elseif CHECK_FLAKE8() == true then
            lint.try_lint('flake8')
          else
            lint.try_lint('flake8')
          end
        end
        lint.try_lint()
      end,
    })
  end,
}
