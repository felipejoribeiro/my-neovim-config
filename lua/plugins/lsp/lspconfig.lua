require('core.utils')

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local util = require('lspconfig.util')

    local signs = { Error = ' ', Warn = ' ', Hint = 'ﴞ ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- INFO: keymaps
    local opts = { silent = true }
    local on_attach = function(_, bufnr)
      opts.desc = 'LSP references in telescope'
      MAPKEYBUF(bufnr, 'n', 'gr', ':Telescope lsp_references<CR>', opts)

      opts.desc = 'Show LSP definitions'
      MAPKEYBUF(bufnr, 'n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)
      MAPKEYBUF(bufnr, 'n', 'gD', ':Telescope lsp_definitions<CR>', opts)

      opts.desc = 'Show LSP type definitions'
      MAPKEYBUF(bufnr, 'n', 'gy', ':Telescope lsp_type_definitions<CR>', opts)

      opts.desc = 'Show LSP implementations'
      MAPKEYBUF(bufnr, 'n', 'gi', ':Telescope lsp_implementations<CR>', opts)

      opts.desc = 'See available code actions'
      MAPKEYBUF(bufnr, 'n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)

      opts.desc = 'Smart rename'
      MAPKEYBUF(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

      opts.desc = 'Show buffer diagnostics'
      MAPKEYBUF(bufnr, 'n', 'gb', ':Telescope diagnostics bufnr=' .. bufnr .. '<CR>', opts)

      opts.desc = 'Go to previous diagnostic'
      MAPKEYBUF(bufnr, 'n', '[g', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

      opts.desc = 'Go to next diagnostic'
      MAPKEYBUF(bufnr, 'n', ']g', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

      opts.desc = 'Show documentation for what is under cursor'
      MAPKEYBUF(bufnr, 'n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)

      opts.desc = 'Restart LSP'
      MAPKEYBUF(bufnr, 'n', '<leader>rs', ':LspRestart<CR>', opts)

      opts.desc = 'toggle LSP terminal'
      MAPKEYBUF(bufnr, 'n', '<leader>b', ':Lspsaga term_toggle<CR>', opts)
    end

    local capabilities =
      cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- WARNING: install bash-language-server
    lspconfig['bashls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- WARNING: install the godot editor https://github.com/habamax/vim-godot
    lspconfig['gdscript'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['ts_ls'].setup({
      init_options = {
        preferences = { includeCompletionsForModuleExports = false },
      },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['gradle_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['html'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['cssls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['jsonls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['pyright'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      before_init = function(_, config)
        config.settings.python.analysis.stubPath =
          vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy', 'python-type-stubs')
      end,
    })

    lspconfig['csharp_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['svelte'].setup({
      filetypes = { 'svelte' },
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd('BufWritePost', {
          pattern = { '*.js', '*.ts', '*.svelte' },
          callback = function(ctx)
            if client.name == 'svelte' or vim.bo[bufnr].filetype == 'svelte' then
              client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
            end
          end,
        })
      end,
    })

    lspconfig['gopls'].setup({
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['rust_analyzer'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
    })
  end,
}
