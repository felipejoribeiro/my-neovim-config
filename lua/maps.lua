-- All global mappings for my nvim config
-- Author: @felipejoribeiro

-- Functional wrapper for mapping custom keybindings
local map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local buf_map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
end

-- map the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- function to show hidden characters
SHOW_HIDDEN = function()
	local show = vim.wo.list
	vim.wo.list = not show
	vim.opt.listchars = { space = ".", tab = ">~", eol = "¬", trail = "·" }
end
map("n", "<leader>s", "<cmd>lua SHOW_HIDDEN()<CR>")

-- pluggin mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fs", "<cmd>Telescope grep_string<CR>")
map("n", "<leader>ft", "<cmd>TodoTelescope <CR>")
map("n", "<leader>fh", "<cmd>Telesope help_tags<CR>")
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').git_branches()<CR>")

map("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>")
map("n", "<leader>m", "<cmd>MinimapToggle<CR>")

map("n", "<leader>h", "<cmd>HopChar2<CR>")
map("n", "<leader>H", "<cmd>HopChar1<CR>")

map("n", "<Leader>w", "<cmd>TranslateW --engines=google --target_lang=pt<CR>", { silent = true })
map("n", "<Leader>W", "<cmd>TranslateW --engines=google --target_lang=en<CR>", { silent = true })
map("v", "<Leader>w", ":'<,'>TranslateW --engines=google --target_lang=pt<CR>", { silent = true })
map("v", "<Leader>W", ":'<,'>TranslateW --engines=google --target_lang=en<CR>", { silent = true })

map("v", "<leader>ss", ":Google<CR>")
map("n", "<leader>ss", ":Google<CR>")

map("n", "<leader>gs", "<cmd>G<CR>")
map("n", "<leader>gb", "<cmd>Git blame<CR>")
map("n", "gD", "<cmd>Gitsigns diffthis<CR>")

map("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
map("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
map("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
map("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
map("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
map("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]])

map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { silent = true })

map("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { silent = true })

map("n", "<leader>p", "<cmd>PencilToggle<CR>", { silent = true })

-- General life enhancements
map("i", "jj", "<esc>")
map("n", "c", '"_c') -- doesn't override ctrl-c
map("v", "c", '"_c') -- doesn't override ctrl-c
map("n", "<leader>R", "<cmd>tabe $MYVIMRC<CR>")
map("n", "<leader>q", "<cmd>qa!<CR>")
map("n", "<leader>x", "<cmd>q<CR>")
map("n", "<leader>+", "<C-a>")
map("n", "<leader>=", "<C-x>")

-- spell check
map("n", "<leader>ss", "<cmd>setlocal spell!<CR>")

-- windows
map("n", "<leader>sv", "<C-w>v<C-w>l")
map("n", "<leader>sh", "<C-w>s<C-w>j")
map("n", "<leader>se", "<C-w>=")
map("n", "<leader>tl", "<cmd>tabnew<CR>")

-- window size
map("n", "<A-J>", "4<C-w>-")
map("n", "<A-K>", "4<C-w>+")
map("n", "<A-L>", "4<C-w>>")
map("n", "<A-H>", "4<C-w><")

-- keep screen centralized when jumping
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- better undo when writing prose
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- copilot accept suggestions
map("i", "<C-k>", "copilot#Accept('')", { expr = true, silent = true })

-- toogle search highlight
map("n", "<leader>/", ":set hlsearch!<CR>")

-- toogle relative line numbers
map("n", "<leader>n", "<cmd>set relativenumber!<CR>")

-- Tests
vim.api.nvim_set_keymap(
	"n",
	"<leader>tt",
	[[ <Cmd>lua require("neotest").run.run()<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>tf",
	[[ <Cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>td",
	[[ <Cmd>lua require("neotest").run.run({strategy = "dap"})<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>to",
	[[ <Cmd>lua require("neotest").output.open()<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ts",
	[[ <Cmd>lua require("neotest").summary.toggle()<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ta",
	[[ <Cmd>lua require("neotest").run.attach())<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<silent>[n",
	[[ <Cmd>lua require("neotest").jump.prev()<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<silent>[n",
	[[ <Cmd>lua require("neotest").jump.next()<CR>]],
	{ noremap = true, silent = true, expr = false }
)

-- File type dependent commands
local function file_type_commands()
	local ft = vim.bo.filetype
	if ft == "markdown" then
		buf_map("n", "<leader>j", "<cmd>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
	end
end
vim.api.nvim_create_autocmd("FileType", { callback = file_type_commands })

-- comments:
-- gco, gcO, gcA, gcc, gbc

-- info:
-- to turn everything into tabs ==> :%s/  /\t/g
-- to turn everything into tabs ==> set noet ci pi sts=0 sw=2 ts=2
