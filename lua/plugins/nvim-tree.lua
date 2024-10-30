require('core.utils')
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'mikew/nvim-drawer',
  },
  config = function()
    local drawer = require('nvim-drawer')
    drawer.setup()

    drawer.create_drawer({
      nvim_tree_hack = true,
      position = 'left',
      size = 40,
      on_did_create_buffer = function()
        local nvim_tree_api = require('nvim-tree.api')
        nvim_tree_api.tree.open({ current_window = true })
      end,
      on_did_open = function()
        local nvim_tree_api = require('nvim-tree.api')
        nvim_tree_api.tree.reload()

        vim.opt_local.number = false
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.statuscolumn = ''
      end,

      on_did_close = function()
        local nvim_tree_api = require('nvim-tree.api')
        nvim_tree_api.tree.close()
      end,
    })

    local glo = vim.g
    local nvimtree = require('nvim-tree')

    -- recommended global configs
    glo.loaded = 1
    glo.loaded_netrw = 1
    glo.loaded_netrwPlugin = 1

    -- INFO: keymaps
    MAPKEY('n', '<leader>E', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' }) -- collapse file explorer
    MAPKEY('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file explorer' }) -- toggle file explorer

    -- customized colors
    local highlights = {
      NvimTreeIndentMarker = { fg = '#CC88FF' },
      NvimTreeNormal = { bg = nil },
    }
    LOAD_HIGHLIGHTS(highlights)

    -- nvim-tree buffer only keymaps
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')
      local function opts(desc)
        return {
          desc = 'nvim-tree: ' .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- custom mappings
      vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
    end

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        adaptive_size = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '',
              arrow_open = '',
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      tab = {
        sync = { open = true, close = true },
      },
      hijack_cursor = true,
      on_attach = on_attach,
      diagnostics = { enable = true },
      auto_reload_on_write = true,
      filters = {
        dotfiles = true,
        custom = {
          '.DS_Store',
        },
        exclude = {},
      },
    })
  end,
}
