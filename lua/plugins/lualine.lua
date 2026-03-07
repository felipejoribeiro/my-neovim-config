return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require('lualine')

    local function lsp_based_filename()
      if pcall(require, 'lspsaga.symbol.winbar') then
        local output = require('lspsaga.symbol.winbar').get_bar()
        if output ~= nil then
          return output
        else
          return ''
        end
      end
    end

    local function lsp_based_filename_cond()
      if pcall(require, 'lspsaga.symbol.winbar') then
        return require('lspsaga.symbol.winbar').get_bar() == nil
      else
        return true
      end
    end

    lualine.setup({
      options = {
        theme = 'iceberg_dark',
      },
      sections = {
        lualine_b = {
          { 'branch', icon = '' },
        },
        lualine_c = {
          { 'filename', file_status = true, path = 4, cond = lsp_based_filename_cond },
          {
            lsp_based_filename,
            color = { bg = 'grey' },
            events = {
              'CursorMoved',
            },
          },
        },
        lualine_x = {
          {
            function()
              local config_dir = vim.env.CLAUDE_CONFIG_DIR or ''
              if string.match(config_dir, 'miio') then
                return ' miio'
              else
                return ' personal'
              end
            end,
            color = function()
              local config_dir = vim.env.CLAUDE_CONFIG_DIR or ''
              if string.match(config_dir, 'miio') then
                return { fg = '#f0a500' }
              else
                return { fg = '#89b4fa' }
              end
            end,
          },
          'ccusage',
        },
      },
    })
  end,
}
