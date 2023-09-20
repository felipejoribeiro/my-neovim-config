-- LSP configuration
-- Author: @felipejoribeiro

-- utils
local home = os.getenv("HOME")

local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
local words = {}

for word in io.open(path, "r"):lines() do
	table.insert(words, word)
end

---------------------------------------------------------
--- Language server configuration
---------------------------------------------------------
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end
local tsstatus, typescript = pcall(require, "typescript")
if not tsstatus then
	return
end
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end
local mason_lspc_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspc_status then
	return
end
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"eslint_d",
	},
})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.eslint_d,
		formatting.stylua,
		diagnostics.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.js")
			end,
		}),
		code_actions.gitsigns,
		code_actions.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.js")
			end,
		}),
	},
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

---------------------------------------------------------
--- Initializing servers with on_attach and capabilities
---------------------------------------------------------
local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>aw", "<cmd>Lspsaga code_action<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

	-- language server specifi configuration
	if client.name == "tsserver" then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rf", "<cmd>TypescriptRenameFile<CR>", opts)
	end
end

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local mason_servers = {
	"tsserver",
	"html",
	"cssls",
	"jsonls",
	"fortls",
	"tailwindcss",
	"lua_ls",
}

local lsp_servers = {
	"bashls", -- npm install -g bash-language-server
	"gdscript", -- install the godot editor https://github.com/habamax/vim-godot
	"jedi_language_server",
}

mason.setup()
mason_lspconfig.setup({ ensure_installed = mason_servers })

-- concatenate lsp_servers and mason_servers
for _, v in ipairs(mason_servers) do
	table.insert(lsp_servers, v)
end

for _, server in ipairs(lsp_servers) do
	local file_type = vim.api.nvim_buf_get_option(0, "filetype")
	local opt = {}
	opt.on_attach = on_attach
	opt.capabilities = capabilities

	if server == "gdscript" then
		opt.flags = {
			debounce_text_changes = 150,
		}
		opt.on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			local _notify = client.notify
			client.notify = function(method, params)
				if method == "textDocument/didClose" then
					-- Godot doesn't implement didClose yet
					return
				end
				_notify(method, params)
			end
		end
		opt.filetypes = { "gd", "gdscript", "gdscript3" }
	end

	if server == "sumneko_lua" then
		opt.settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim", "use" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("config") .. "/lua"] = true,
					},
				},
			},
		}
	end

	-- if server == "ltex" and (file_type == "tex" or file_type == "md") then
	-- 	opt.settings = {
	-- 		ltex = {
	-- 			enabled = { "latex", "tex", "bib", "markdown" },
	-- 			language = "auto",
	-- 			diagnosticSeverity = "information",
	-- 			setenceCacheSize = 2000,
	-- 			checkFrequency = "edit",
	-- 			trace = { server = "off" },
	-- 			additionalRules = {
	-- 				motherTongue = "pt-BR",
	-- 			},
	-- 		},
	-- 	}
	--
	-- 	opt.on_attach = function(client, bufnr)
	-- 		on_attach(client, bufnr)
	-- 		require("ltex_extra").setup({
	-- 			load_langs = { "en-US", "pt-BR" }, -- table <string> : languages for witch dictionaries will be loaded
	-- 			init_check = true,
	-- 			path = home .. "/.config/nvim/grammar",
	-- 			log_level = "error",
	-- 		})
	-- 	end
	-- end
	lspconfig[server].setup(opt)
end

typescript.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
