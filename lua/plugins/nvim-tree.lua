require("core.utils")
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    local glo = vim.g
    local nvimtree = require('nvim-tree')

    -- recommended global configs
    glo.loaded = 1
    glo.loaded_netrw = 1
    glo.loaded_netrwPlugin = 1

    -- INFO: keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>E", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    
    -- customized colors
    local highlights = {
      NvimTreeIndentMarker = {fg = "#00FF00"},
      NvimTreeNormal = {bg = null},
    }
    LOAD_HIGHLIGHTS(highlights)

    -- nvim-tree buffer only keymaps
    local function on_attach(bufnr)
      local api = require "nvim-tree.api"
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- custom mappings
      vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
    end

    -- configure nvim-tree
    nvimtree.setup({
      -- change folder state icons
      renderer = {
        indent_markers = {
          enable = true
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },
      tab ={
        sync = { open = true, close = true }
      },
      hijack_cursor = true,
      on_attach = on_attach,
      diagnostics = { enable = false },
      auto_reload_on_write = true,
      filters = {
        dotfiles = true,
        custom = {},
        exclude = {},
      },
    })
  end
}
