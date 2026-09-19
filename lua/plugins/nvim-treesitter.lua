-- nvim-treesitter `main` branch (the supported branch for Neovim 0.11+).
-- This is a full rewrite of the plugin: the old `.configs.setup{ensure_installed,
-- highlight, indent, autotag}` API no longer exists. Parsers are installed via
-- `install()`, and highlighting/indent are enabled per-buffer ourselves.
local ensure_installed = {
  'yaml',
  'html',
  'css',
  'lua',
  'python',
  'markdown',
  'markdown_inline',
  'javascript',
  'json',
  'typescript',
  'tsx',
  'svelte',
  'graphql',
  'bash',
  'gitignore',
  'vim',
  'vimdoc',
  'query',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    -- `main` does not support lazy-loading; load at startup.
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()

      -- Install the parsers we want (async no-op if already present).
      require('nvim-treesitter').install(ensure_installed)

      -- Highlighting and indentation are NOT automatic on `main`; enable them
      -- per-buffer for any filetype that has a parser available.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
        callback = function(ev)
          -- vim.treesitter.start auto-detects the language from filetype and
          -- errors if no parser is installed yet, so guard with pcall.
          if pcall(vim.treesitter.start, ev.buf) then
            -- Treesitter indent is experimental but matches the previous
            -- `indent = { enable = true }` behaviour.
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            -- Preserve the old `additional_vim_regex_highlighting = {'markdown'}`
            -- by also enabling Vim's regex syntax for markdown.
            if ev.match == 'markdown' then
              vim.bo[ev.buf].syntax = 'on'
            end
          end
        end,
      })
    end,
  },

  -- Autotag was a treesitter module on `master`; on `main` it is a standalone
  -- plugin with its own setup.
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
}
