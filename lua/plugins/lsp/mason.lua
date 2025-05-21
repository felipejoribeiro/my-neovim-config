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
        'gopls',
      },
      automatic_installation = true,
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
