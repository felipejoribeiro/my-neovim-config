-- Nvim lua configuration
-- Works perfectly on MAC and LINUX
-- Author: @felipejoribeiro

-- aliases
local opt = vim.opt

-- global configuration
opt.termguicolors = true -- force gui colors
opt.background = 'dark' -- set background to dark
opt.signcolumn = 'yes' -- always show signcolumn
opt.fileformat = 'unix' -- set file format
opt.clipboard:append('unnamedplus') -- use system clipboard as default register

-- On Linux, force xclip; default xsel --nodetach freezes Brave 1.90 (see brave/brave-browser#55829).
-- On macOS, leave vim.g.clipboard unset so Neovim picks pbcopy/pbpaste.
if vim.fn.has('mac') == 0 and vim.fn.has('unix') == 1 and vim.fn.executable('xclip') == 1 then
  vim.g.clipboard = {
    name = 'xclip',
    copy = {
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection primary',
    },
    paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection primary -o',
    },
    cache_enabled = 0,
  }
end
opt.shortmess = vim.o.shortmess .. 'c' -- don't print short messages
opt.completeopt = 'menuone,noselect' -- complete options
opt.backspace = 'indent,eol,start' -- backspace options
opt.mouse = 'a' -- enable mouse support
opt.wrap = false -- disable line wrap by default
opt.laststatus = 3 -- views can only be fully collapsed with the global statusline

-- backup configuration
opt.undofile = true -- persistent undo
opt.undodir = vim.env.HOME .. '/.config/nvim/undodir' -- where to save undo
opt.viewoptions = 'cursor,folds,slash,unix' -- for save state
opt.backup = false -- disable backup files
opt.writebackup = false -- prevents writing backup
opt.swapfile = false -- disable swap file creation

-- visuals
opt.number = true -- create number column
opt.relativenumber = true -- relative number
opt.cursorline = true -- highlight cursor line
opt.scrolloff = 4 -- make the cursor stay in center
opt.sidescrolloff = 4 -- make cursor stay in center
opt.cmdheight = 1 -- number of lines for commands
opt.showcmd = false -- don't show key pressed
opt.scl = 'yes' -- show cursor line
opt.filetype = 'detect' -- detect file type

-- function
opt.ignorecase = true -- ignore case in search
opt.smartcase = true -- smartly ignore case
opt.title = true -- set window title
opt.splitbelow = true -- default split behaviour
opt.splitright = true -- default split behaviour
opt.spell = false -- enable spell
opt.spellfile = vim.env.HOME .. '/.config/nvim/spell/language.utf-8.add'
opt.spelllang = 'en,pt' -- spell languages

-- time to wait for commands
opt.ttimeout = true -- makes things faster
opt.updatetime = 300 -- faster completion
opt.timeoutlen = 400 -- by default 1000ms
opt.ttimeoutlen = 80 -- makes things faster

-- middle east characters right to left paste support
opt.arabicshape = true
opt.allowrevins = true

-- add python3 host prog
vim.g.python3_host_prog = '/usr/bin/python3'

-- conceal level for markdown
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_conceal = 2
opt.conceallevel = 1

-- autocommand on buffer enter to set tab x space
opt.autoindent = true -- auto indentation
vim.cmd([[
  augroup FileTypeIndent
    autocmd!
    autocmd FileType * setlocal tabstop=2 shiftwidth=2 expandtab smartindent
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab smartindent
    autocmd FileType bash setlocal tabstop=2 shiftwidth=2 expandtab smartindent
    autocmd FileType cs setlocal tabstop=4 shiftwidth=4 expandtab smartindent
    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab smartindent
    autocmd FileType rust setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smartindent
    autocmd FileType make setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
    autocmd FileType go setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
    autocmd FileType sql setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType gdscript setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
  augroup END
]])

-- diagnostic signs
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  severity_sort = false,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = '󰋼 ',
      [vim.diagnostic.severity.HINT] = '󰌵 ',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
})

-- keyword keys
opt.iskeyword = opt.iskeyword + '-' -- treat dash separated words as a word text object"

-- loading configs
require('core.keymaps')
require('core.lazy')
