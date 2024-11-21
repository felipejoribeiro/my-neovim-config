return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { 'eslint' },
      javascriptreact = { 'eslint' },
      svelte = { 'eslint' },
      python = { 'flake8' }, -- WARNING: Install the tool with pip! (flake8 package)
      csharp = { 'sonarlint-language-server' },
      go = { 'golangci-lint' },
      sql = { 'sqlfluff' }, -- WARNING: Install the tool globally
      make = { 'checkmake' },
    }

    local sqlfluff = require('lint').linters.sqlfluff
    sqlfluff.args = {
      'lint',
      '--format=json',
      '--dialect=postgres',
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
      pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.svelte', '*.py', '*.sql', 'Makefile' },
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
