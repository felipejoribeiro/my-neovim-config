require('core.utils')
require('core.lsp_identifiers')

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')

    -- INFO: keymaps
    MAPKEY(
      'n',
      'gf',
      '<cmd>lua conform.format({lsp_fallback = true, async = false, timeout_ms = 500})<CR>'
    )

    local python_formatter = CHECK_RUFF() and { 'ruff_format' } or { 'black', 'isort' }

    conform.setup({
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascriptreact = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        lua = { 'stylua' },
        python = python_formatter,
        go = { 'gofumpt', 'goimports-reviser', 'golines' },
        sql = { 'sqlfmt' }, -- WARNING: install sqlfmt
      },
      format_after_save = {
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
      },
    })
  end,
}
