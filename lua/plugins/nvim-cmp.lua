return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip", -- snippets engine
    "petertriho/cmp-git", -- git source for nvim-cmp
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer", -- buffer source for nvim-cmp
    "hrsh7th/cmp-path", -- path source for nvim-cmp
    "hrsh7th/cmp-cmdline", -- cmdline source for nvim-cmp
    "f3fora/cmp-spell", -- spell source for nvim-cmp
    "rafamadriz/friendly-snippets", -- good snippets
    "saadparwaiz1/cmp_luasnip", -- snippets source for nvim-cmp
    "onsails/lspkind.nvim", -- icons for nvim-cmp
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      -- INFO: keymaps
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<M-e>'] = cmp.mapping.abort(),
        ['<C-j>'] = cmp.mapping.confirm({ select = true }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
          local check_backspace = function()
            local col = vim.fn.col "." - 1
            return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
          end

          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure nvim-cmp x snippet engine interaction
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
      },
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = 'nvim_lsp'},
        { name = 'luasnip'},
        { name = 'buffer'},
        { name = 'path'},
        { name = 'spell'},
        { name = 'gitlint'}
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        }),
      },
      -- appearance
      style = {
        winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
      },
      -- window appearance
      window = {
        fields = { "kind", "abbr", "menu" },
        completion = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          scrollbar = "║",
          autocomplete = {
            require("cmp.types").cmp.TriggerEvent.InsertEnter,
            require("cmp.types").cmp.TriggerEvent.TextChanged,
          },
        },
        documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, scrollbar = "║" },
      },
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' },
        { name = 'gitlint'},
        { name = 'spell' },
        { name = 'buffer' },
      })
    })
  end,
}
