require("core.utils")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- INFO: keymaps
    vim.api.nvim_echo({ { "LSP loaded" } }, true, {})
    local opts = { silent = true }
    local on_attach = function(_, bufnr)
      vim.api.nvim_echo({ { "LSP on_attach started" } }, true, {})

      opts.desc = "LSP references in telescope"
      MAPKEYBUF(bufnr, "n", "gr", ":Telescope lsp_references<CR>", opts)

      opts.desc = "Show LSP definitions"
      MAPKEYBUF(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
      MAPKEYBUF(bufnr, "n", "gD", ":Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP type definitions"
      MAPKEYBUF(bufnr, "n", "gy", ":Telescope lsp_type_definitions<CR>", opts)


      opts.desc = "Show LSP implementations"
      MAPKEYBUF(bufnr, "n", "gi", ":Telescope lsp_implementations<CR>", opts)

      opts.desc = "See available code actions"
      MAPKEYBUF(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

      opts.desc = "Smart rename"
      MAPKEYBUF(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

      opts.desc = "Show buffer diagnostics"
      MAPKEYBUF(bufnr, "n", "gb", ":Telescope diagnostics bufnr=" .. bufnr .. "<CR>", opts)

      opts.desc = "Go to previous diagnostic"
      MAPKEYBUF(bufnr, "n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

      opts.desc = "Go to next diagnostic"
      MAPKEYBUF(bufnr, "n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

      opts.desc = "Show documentation for what is under cursor"
      MAPKEYBUF(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

      opts.desc = "Restart LSP"
      MAPKEYBUF(bufnr, "n", "<leader>rs", ":LspRestart<CR>", opts)

      opts.desc = "format buffer"
      MAPKEYBUF(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- WARNING: install bash-language-server
    lspconfig["bashls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end,
        })
      end,
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}
