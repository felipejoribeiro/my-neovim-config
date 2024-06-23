return {
  'akinsho/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    Capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- INFO: keymaps
    local opts = { silent = true }
    On_attach = function(_, bufnr)
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

    require('flutter-tools').setup({
      debugger = {
        enabled = true,
        run_via_dap = true,
        register_configurations = function(_)
          require('dap').adapters.dart = {
            type = 'executable',
            command = vim.fn.stdpath('data') .. '/mason/bin/dart-debug-adapter',
            args = { 'flutter' },
          }
        end,
      },
      dev_log = {
        enabled = true,
        open_cmd = 'tabedit',
      },
      experimental = { lsp_derive_paths = true },
      widget_guides = { enabled = true },
      lsp = {
        on_attach = On_attach,
        capabilities = Capabilities,
      },
    })
  end,
}
