require('core.utils')

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'nanotee/sqls.nvim',
    'b0o/schemastore.nvim',
  },
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
    MAPKEY('n', '<leader>b', ':Lspsaga term_toggle<CR>', { silent = true })
    local opts = { silent = true }
    local on_attach = function(_, bufnr)
      opts.desc = 'Toggle inlay hints'
      MAPKEY(
        'n',
        '<leader>hd',
        ':lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
        opts
      )

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
    end

    local capabilities =
      cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- WARNING: install bash-language-server
    -- WARNING: install the godot editor https://github.com/habamax/vim-godot
    -- WARNING: install sqls with go install github.com/lighttiger2505/sqls
    vim.lsp.config('*', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Only works in legacy config
    -- lspconfig.gdscript.setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    vim.lsp.config('gdscript', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('ts_ls', {
      on_attach = on_attach,
      init_options = {
        preferences = { includeCompletionsForModuleExports = false },
      },
    })

    vim.lsp.config('pyright', {
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            stubPath = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy', 'python-type-stubs'),
            typeCheckingMode = 'off',
          },
        },
      },
    })

    vim.lsp.config('svelte', {
      filetypes = { 'svelte' },
      init_options = {
        provideFormatter = false,
      },
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd('BufWritePost', {
          pattern = { '*.js', '*.ts', '*.jsx', '*.tsx', '*.svelte' },
          callback = function(ctx)
            if client.name == 'svelte' or vim.bo[bufnr].filetype == 'svelte' then
              client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
            end
          end,
        })
      end,
    })
  end,
}
