-- All global mappings for my nvim config
-- Author: @felipejoribeiro

-- map the leader key
require("core.utils")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- show hidden files
MAPKEY("n", "<leader>s", "<cmd>lua SHOW_HIDDEN()<CR>")

-- life enhancements
MAPKEY("i", "jj", "<esc>")
MAPKEY("n", "c", '"_c') -- doesn't override ctrl-c
MAPKEY("v", "c", '"_c') -- doesn't override ctrl-c
MAPKEY("n", "<leader>R", "<cmd>tabe $MYVIMRC<CR>")
MAPKEY("n", "<leader>q", "<cmd>qa!<CR>")
MAPKEY("n", "<leader>x", "<cmd>q!<CR>")

-- windows
MAPKEY("n", "<leader>sv", "<C-w>v<C-w>l")
MAPKEY("n", "<leader>sh", "<C-w>s<C-w>j")
MAPKEY("n", "<leader>se", "<C-w>=")
MAPKEY("n", "<leader>tl", "<cmd>tabnew<CR>")

-- window size
MAPKEY("n", "<A-J>", "4<C-w>-")
MAPKEY("n", "<A-K>", "4<C-w>+")
MAPKEY("n", "<A-L>", "4<C-w>>")
MAPKEY("n", "<A-H>", "4<C-w><")

-- keep screen centralized when jumping
MAPKEY("n", "n", "nzzzv")
MAPKEY("n", "N", "Nzzzv")
MAPKEY("n", "J", "mzJ`z")

-- better undo when writing prose
MAPKEY("i", ",", ",<c-g>u")
MAPKEY("i", ".", ".<c-g>u")
MAPKEY("i", "!", "!<c-g>u")
MAPKEY("i", "?", "?<c-g>u")

-- spell check
MAPKEY("n", "<leader>sS", "<cmd>setlocal spell!<CR>")

-- toogle search highlight
MAPKEY("n", "<leader>/", ":set hlsearch!<CR>")

-- toogle relative line numbers
MAPKEY("n", "<leader>sn", "<cmd>set relativenumber!<CR>")
