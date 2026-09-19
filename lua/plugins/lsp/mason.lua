return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- All packages are installed in ~/.local/share/nvim/mason
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    mason.setup({})
    mason_lspconfig.setup({
      ensure_installed = {
        'ts_ls',
        'html',
        'cssls',
        'jsonls',
        'svelte',
        'lua_ls',
        'emmet_ls',
      },
      automatic_installation = true,
      -- nvim-lspconfig now ships an `lsp/stylua.lua` (cmd: `stylua --lsp`), and
      -- automatic_enable would start it for every Lua buffer. The installed
      -- stylua has no `--lsp` flag, so it crashes. We only use stylua as a
      -- conform formatter, so exclude it from being enabled as an LSP server.
      automatic_enable = { exclude = { 'stylua' } },
    })
    mason_tool_installer.setup({
      ensure_installed = {
        'prettier',
        'stylua',
        'dcm',
        'gofumpt',
        'goimports-reviser',
        'golines',
        'isort',
        'black',
        'eslint',
        'pylint',
      },
      automatic_installation = true,
    })
  end,
}
