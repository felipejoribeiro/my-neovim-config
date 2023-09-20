"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        General Configuration                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configs
syntax enable                           " Enable syntax
set t_Co=256                            " Supports 256 colors
filetype indent plugin on               " enable file detection and plugins
set termguicolors                       " Use GUI colors always
set encoding=utf-8                      " The encoding written to file
set fileencoding=utf-8                  " utf8 encoding
set fileformat=unix                     " Set file format to a global one

set clipboard=unnamedplus               " Use system's clipboard

set shortmess+=c                        " Don't pass messages too short
set mouse=a                             " Mouse support
set noerrorbells                        " No sounds

" Persistence options
set undofile                            " Persistent undo 
set undodir=~/.config/nvim/undodir      " Place to save undo history
set nobackup                            " Disable backup files
set nowritebackup                       " Don't write to backup files
set noswapfile                          " Disable swap file creation
set viewoptions=cursor,folds,slash,unix " view options (for save state)
set sessionoptions+=tabpages,globals    " Some options to session remember

" Search options
set incsearch                           " Incremental search highlight
set smartcase                           " Ignore case in search if minuscule

" Load options
set exrc                                " Ex .nvimrc file in cwd on init
set hidden                              " Permit hidden buffers not saved
set autoread                            " Auto load file change disco

" Visual options
set number                              " Creates the left column
set nowrap                              " No word wrapping in general nvim
set scrolloff=4                         " Make the cursor stay in center
set sidescrolloff=4                     " Make cursor stay in center
set cmdheight=1                         " Number of lines to display commands
set noshowcmd                           " Don't show key pressed
set title                               " Set window title
set foldmethod=syntax                   " enable fold
set foldlevelstart=99                   " disable all folds in open
set list lcs=tab:\⨒\                    " Enable tab character 

" Update options
set ttimeout                            " Makes things faster
set updatetime=300                      " Faster completion
set timeoutlen=400                      " by default 1000ms
set ttimeoutlen=80                      " Makes things faster

" Functional options
let g:mapleader=" "                     " Map leader to space bar
let maplocalleader=" "                  " More leader to space bar
set backspace=indent,eol,start          " Makes sure back space works
set splitbelow                          " Default split begaviour

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Auto install vim-Plug                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Plug's                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

	" Indirect utilities
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " 🏹 Visual tools for pluggins - dependence of rainbow
	Plug 'nvim-lua/plenary.nvim'                                  " 🏹 Lua libs - dependence of telescope
	Plug 'nvim-lua/popup.nvim'                                    " 🏹 Create windows - dependence of telescope
	Plug 'kyazdani42/nvim-web-devicons'                           " 🏹 Icons of programing languages nd stuff
	" Plug 'tpope/vim-scriptease'                                   " ✔  Helps with source reloads
	Plug 'kamykn/popup-menu.nvim'                                 " 🏹  Create window too.
	Plug 'skywind3000/asyncrun.vim'                               " 💚  Asynchronous commands

	" History related stuff
	Plug 'vim-scripts/restore_view.vim'                           " ✔ Save cursor position and folds
	Plug 'mbbill/undotree'                                        " 💚 Undo tree creation visualization - bug with folds

	" Code dev direct enhancements
	Plug 'jiangmiao/auto-pairs'                                   " ⏳  auto pairs functionality and movements
	Plug 'tpope/vim-surround'                                     " ⏳  Auto pairs functions
	Plug 'sirver/ultisnips'                                       " ⏳  Best snippets functions
	Plug 'tomtom/tcomment_vim'                                    " 💚  Better comments with g c c too
	Plug 'KabbAmine/vCoolor.vim'                                  " 💚  GTK color picker
	Plug 'phaazon/hop.nvim'                                       " 👀  fast travel

	" Visual stuff
	Plug 'yuttie/comfortable-motion.vim'                          " 💚  Best scrolling with keyboard
	Plug 'vim-airline/vim-airline'                                " 💚  Beautiful bellow bar
	Plug 'vim-airline/vim-airline-themes'                         " 💚  Themes for the airline bar
	Plug 'dracula/vim', { 'as': 'dracula' }                       " 💚  Theme for Dracula
	Plug 'yggdroot/indentLine'                                    " 💚  good indent lines with space
	Plug 'folke/todo-comments.nvim'                               " 💚  Comments like todo
	Plug 'wfxr/minimap.vim'                                       " 👀  code minimap

	" IDE utilities
	Plug 'zhimsel/vim-stay'                                       " 👀 Save folds for next session
	Plug 'neoclide/coc.nvim', {'branch': 'release'}               " ✏  More ide capabilities
	Plug 'mhinz/vim-startify'                                     " ✔  Start screen for neovim
	Plug 'nvim-telescope/telescope.nvim'                          " ✔  DAMN fuzzy finder
	Plug 'nvim-telescope/telescope-fzy-native.nvim'               " ✔  Makes fuzzy finder faster
	Plug 'puremourning/vimspector'                                " 👀 Debugging capabilities for vim 
	Plug 'mfussenegger/nvim-dap'                                  " 👀 Debugging capabilities for vim 
	Plug 'Pocco81/DAPInstall.nvim'                                " 👀 Install debuggers
	Plug 'David-Kunz/jester'                                      " 👀 test suit
	Plug 'vim-test/vim-test'

	" Some Third party integration
	Plug 'christoomey/vim-tmux-navigator'                         " ✔  tmux integration
	Plug 'szw/vim-g'                                              " ✔  Easy Google search from Vim
	Plug 'voldikss/vim-translator'                                " ✔  Translation tool from google trans.
	Plug 'tpope/vim-fugitive'                                     " ✔  Git super powers
	Plug 'tpope/vim-rhubarb'                                      " 👀 Enable github integration
	Plug 'airblade/vim-gitgutter'                                 " ✔  Some more git functionalities
	Plug 'wakatime/vim-wakatime'                                  " ✔  Time monitoring software
	Plug 'editorconfig/editorconfig-vim'                          " ✔  Integrate vim with .editorconfig file
	Plug 'fladson/vim-kitty'

	" Python :
	" Plug 'vim-scripts/indentpython.vim', {'for' : 'python'}       " 👀 Create better indentation 
	" Plug 'tmhedberg/SimpylFold', {'for' : 'python'}               " 👀 Create better code folding 
	Plug 'jeetsukumaran/vim-pythonsense', {'for' : 'python'}       " ✔  More text objects for python
	Plug 'liuchengxu/vista.vim', {'for' : 'python'}                " ✔ LSP tags and symbols
	Plug 'jmcantrell/vim-virtualenv'                               " virtual env integration

	" Csharp :
	Plug 'OmniSharp/omnisharp-vim', {'for' : 'cs'}                " ✔  Omnisharp capabilities

	" Godot :
	Plug 'habamax/vim-godot'                                      " ✔ Godot ide capabilities
	Plug 'calviken/vim-gdscript3'

	" Latex :
	Plug 'lervag/vimtex', {'for' : 'latex'}                       " ✔  IDLE tools for latex
	Plug 'matze/vim-tex-fold'                                     " 👀 better folding for latex

	" FORTRAN :
	Plug 'rudrab/vimf90'                                          " 👀 Fortran support

	" MarkDown :
	Plug 'godlygeek/tabular', {'for': 'markdown'}                 " ✔  Align text 
	Plug 'plasticboy/vim-markdown', {'for': 'markdown'}           " ✔  Some mark down functionalities
	Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install', 'for': 'markdown'} " ✔  Md preview
	Plug 'aklt/plantuml-syntax', {'for': 'markdown'}              " 👀 Syntax for PlantUML

	" For better text editing
	Plug 'reedes/vim-pencil'
	Plug 'junegunn/goyo.vim', {'for': ['markdown', 'latex']}      " ✏  For minimalistic view

	" web_dev
	Plug 'elzr/vim-json'                                          " 👀 Better jason support
	Plug 'mattn/emmet-vim'                                        " ✔  Create html more ease
	Plug 'AndrewRadev/tagalong.vim'                               " 👀 Better tag editing without vim surround
	Plug 'ianks/vim-tsx'                                          " 👀 Typescrit syntax highlight
	Plug 'leafgarland/typescript-vim'
	Plug 'yuezk/vim-js'                                           " 👀 React syntax highlight
	Plug 'HerringtonDarkholme/yats.vim'                     
	Plug 'MaxMEllon/vim-jsx-pretty', {'for': 'javascript'}        " 👀 React syntax highlight
	Plug 'pangloss/vim-javascript', {'for': 'javascript'}         " 👀 React syntax highlight 
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " 👀 React styled components support

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Looks                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme definition
colorscheme dracula

" Translate borders
hi TranslatorBorder guibg=NONE ctermbg=NONE guifg=white

" Gitgutter delete color option
au BufEnter * hi GitGutterDelete guibg=NONE ctermbg=NONE guifg=#FF4877

" Cursor customization
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkwait200-blinkon100-blinkoff50

" Indent line
let g:indentLine_char_list = ['⨔']
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = '⨔'

" sample settings
hi Pmenu ctermfg=254 ctermbg=237 cterm=NONE guifg=#44ff41 guibg=NONE gui=NONE
hi PmenuSel ctermfg=135 ctermbg=239 cterm=NONE guifg=#ffffff guibg=NONE gui=NONE

hi clear Todo

" General background
hi Normal guibg=NONE ctermbg=NONE

" Syntax highlight
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"lua","python"},
	highlight = {
		enable = true,         -- false will disable the whole extension
		disable = { "html" },  -- list of language that will be disabled
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 1000
	}
}
EOF
lua << EOF
require("todo-comments").setup {
	keywords = {
		BUG = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "#f06caa" },
		WARN = { icon = " ", color = "#ffb86c", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "#9192ff", alt = { "INFO" } },
	},
}
require'hop'.setup()
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    debuggers configurations                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
EOF
lua << EOF
local dap = require('dap')
local dap_install = require("dap-install")

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='✅', texthl='', linehl='', numhl=''})

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = {vim.fn.stdpath("data") .. "/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js"},
}

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>dh', ':lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map('n', '<c-k>', ':lua require"dap".step_out()<CR>')
map('n', "<c-l>", ':lua require"dap".step_into()<CR>')
map('n', '<c-j>', ':lua require"dap".step_over()<CR>')
map('n', '<c-h>', ':lua require"dap".continue()<CR>')
map('n', '<leader>dn', ':lua require"dap".run_to_cursor()<CR>')
map('n', '<leader>dk', ':lua require"dap".up()<CR>')
map('n', '<leader>dj', ':lua require"dap".down()<CR>')
map('n', '<leader>dc', ':lua require"dap".terminate()<CR>')
map('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
map('n', '<leader>dR', ':lua require"dap".clear_breakpoints()<CR>')
map('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>')
map('n', '<leader>da', ':lua require"debugHelper".attach()<CR>')
map('n', '<leader>dA', ':lua require"debugHelper".attachToRemote()<CR>')
map('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

map('n', '<leader>tt', ':lua require"jester".run({ path_to_jest = "/home/fejori/.yarn/bin/jest" })<cr>')
map('n', '<leader>t_', ':lua require"jester".run_last({ path_to_jest = "/home/fejori/.yarn/bin/jest" })<cr>')
map('n', '<leader>tf', ':lua require"jester".run_file({ path_to_jest = "/home/fejori/.yarn/bin/jest" })<cr>')
-- " map('n', '<leader>dd', ':lua require"jester".debug({ path_to_jest = "/home/fejori/.yarn/bin/jest" })<cr>')
map('n', '<leader>d_', ':lua require"jester".debug_last({ path_to_jest = "/home/fejori/.yarn/bin/jest" })<cr>')
map('n', '<leader>df', ':lua require"jester".debug_file({ path_to_jest = "/home/fejori/.yarn/bin/jest" })<cr>')

-- mapping for hop
map('n', '<leader>/', ':HopChar1')

EOF

nnoremap <leader>dd :TestNearest -strategy=jest<CR>
function! JestStrategy(cmd)
	let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
	let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
	call luaeval("require'debugHelper'.debugJest([[" . testName . "]], [[" .fileName. "]])")
endfunction
let g:test#custom_strategies = {'jest': function('JestStrategy')}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Plugins configurations                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" minimap ----
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0
let g:minimap_highlight_search = 1

" comfortable-motion ----
let g:comfortable_motion_no_default_key_mappings = 1
" let g:comfortable_motion_scroll_down_key = "j"
" let g:comfortable_motion_scroll_up_key = "k"

" vista.vim ----
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#icons = {
	\   "function": "\UF794",
	\   "variable": "\UF71B",
	\   "augroup": "👀",
	\  }

" editorconfig-vim ----
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" vim-g ----
let g:vim_g_open_command = "xdg-open"
let g:vim_g_python_command = "python3"
let g:vim_g_query_url = "https://duckduckgo.com/?q="

" vim-translator ----
let g:translator_target_lang = 'english'
let g:translator_window_borderchars = ['-', '|', '-', '|', '+', '+', '+', '+']

" vim-startify ----
let g:html_files_number = 18
let g:startify_session_persistence = 1
let g:startify_relative_path = 1
let g:startify_custom_header = [
	\ "                ",
	\ "  fejori's              ",
	\ "                ",
	\ "    ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
	\ "    ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
	\ "   ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
	\ "   ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ",
	\ "   ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
	\ "   ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
	\ "   ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░",
	\ "      ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ",
	\ "            ░    ░  ░    ░ ░        ░   ░         ░   ",
	\ "                                   ░             ",
	\ '                    ',
	\ ]
let g:startify_lists = [
	\ { 'type': 'sessions',  'header': ['   Saved sessions'] },
	\ { 'type': 'dir',       'header': ['   Recent files'] },
	\ ]

" airline.vim ---- 
set laststatus=2
" let g:airline_theme='dracula'
let g:airline_section_c=''
let g:airline_detect_spelllang=1
let g:airline_detect_spell=1
let g:airline#extensions#whitespace#checks = [ 'indent', 'conflicts' ]
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#enabled = 0 " Enable the list of buffers
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'short_path' " file-name.js
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buf_label_first = 1
let g:airline#extensions#tabline#buffer_min_count = 1
let g:airline#extensions#tabline#tab_min_count = 1
let g:airline#extensions#tabline#buffers_label = 'BUF'
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#scrollbar#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let airline#extensions#coc#error_symbol = ' :'
let airline#extensions#coc#warning_symbol = ' :'
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.dirty=' '
endif
" function! AirLineInit()
" 	let g:airline_section_a = airline#section#create(['mode', 'crypt', 'paste', 'spell', 'iminsert'])
" 	let g:airline_section_b = airline#section#create(['hunks', 'branch'])
" 	let g:airline_section_c = airline#section#create([ 'readonly'])
" 	let g:airline_section_x = airline#section#create(['tagbar', 'filetype'])
" 	let g:airline_section_y = airline#section#create(['fileencoding', 'fileformat', 'bom', 'eol'])
" 	let g:airline_section_z = airline#section#create(['%P', ' ', ' %l ', ' %c𥳐'])
" endfunction
" autocmd VimEnter * call AirLineInit()

"vim-gitgutter ----
let g:gitgutter_enabled=1
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = ' '
let g:gitgutter_sign_modified = '卵'
let g:gitgutter_sign_removed = '嵐'
let g:gitgutter_sign_modified_removed = ' '

" coc.vim ----
let g:airline#extensions#coc#enabled = 1
let g:coc_global_extensions=[
	\ 'coc-spell-checker',
	\ 'coc-pyright',
	\ 'coc-cspell-dicts',
	\ 'coc-cfn-lint',
	\ 'coc-omnisharp',
	\ 'coc-highlight',
	\ 'coc-vimtex',
	\ 'coc-vimlsp',
	\ 'coc-tsserver',
	\ 'coc-tslint-plugin',
	\ 'coc-fzf-preview',
	\ 'coc-emmet',
	\ 'coc-css',
	\ 'coc-html',
	\ 'coc-yank',
	\ 'coc-yaml',
	\ 'coc-sh',
	\ 'coc-eslint',
	\ 'coc-prettier',
	\ 'coc-json',
	\ 'coc-explorer',
	\ 'coc-discord',
	\]
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" vim-move ----
let g:move_key_modifier = 'c'

" auto-pairs ----
" some new ones to html:
au FileType html let b:AutoPairs = AutoPairsDefine({'<\!--' : '-->'})
"this disable auto pairs to stop problems with \":
au BufNewFile,BufRead *.vim let g:AutoPairsMultilineClose = 0

" omnisharp ----
let g:OmniSharp_server_stdio = 1

" vim-pencil ----
let g:pencil#conceallevel = 0 

" vim-json
let g:vim_json_syntax_conceal = 0

" Vimtex ----
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 0
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_forward_search_on_start = 1
let g:tex_conceal = ""
set conceallevel=0

" vim-surround ----
let b:surround_{char2nr('i')} = "\"\"\"\r\"\"\"" 

" ultisnips ----
let g:UltiSnipsExpandTrigger='&u'
let g:UltiSnipsJumpForwardTrigger = '&u'
let g:UltiSnipsJumpBackwardTrigger = '&U'

" SimpylFold ----
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_import=0
let g:SimpylFold_fold_docstring = 0

" vim-markdown ----
let g:vim_markdown_fenced_languages = ['csharp=cs', 'python=python', 'json=javascript', 'plantuml']
let g:vim_markdown_math = 1

" markdown preview ----
let g:mkdp_refresh_slow = 0
let g:mkdp_auto_close = 0
" let g:mkdp_markdown_css = '/home/fejori/.config/nvim/retro_md_css.css'
let g:mkdp_markdown_css = '/home/fejori/.config/nvim/dracula_md_css.css'
" let g:mkdp_markdown_css = '/home/felipejoribeiro/.config/nvim/github_md_css.css'
" let g:mkdp_markdown_css = '/home/felipejoribeiro/.config/nvim/prism_md.css'

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Mapping and auto command                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <LEADER> -----------------------------------
" Git related shortcuts
nmap <leader>gl :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gb :Git blame<CR>

" Debbuging
" nnoremap <Leader>dd :call vimspector#Launch()<CR>
" nnoremap <Leader>de :call vimspector#Reset()<CR>
" nnoremap <Leader>dc :call vimspector#Continue()<CR>
"
" nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
" nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
"
" nmap <Leader>dk <Plug>VimspectorRestart
" nmap <Leader>dh <Plug>VimspectorStepOut
" nmap <Leader>dl <Plug>VimspectorStepInto
" nmap <Leader>dj <Plug>VimspectorStepOver

" Minimap toggle
nnoremap <leader>m :MinimapToggle<CR>

" Search highlight toggle
let hlstate=0
nnoremap <silent> <leader>/ :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr><cr>k

" Open neovim configuration file
nnoremap <leader>r :tabe $MYVIMRC<CR>

" Easy quit
map <silent> <leader>q :SClose<CR> :q<CR>

" Google search
vnoremap <leader>s :Google<CR>
nnoremap <leader>s :Google<CR> 

" Translate
nnoremap <silent> <Leader>w :TranslateW --engines=google --target_lang=pt<CR>
vnoremap <silent> <Leader>w :TranslateW --engines=google --target_lang=pt<CR>
nnoremap <silent> <Leader>W :TranslateW --engines=google --target_lang=en<CR>
vnoremap <silent> <Leader>W :TranslateW --engines=google --target_lang=en<CR>

" Fuzzy finder global configuration
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Todo configuration
nnoremap <leader>ft :TodoTelescope<cr>

" Coc code actions (correct spell for example)
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" Open file tree
" nnoremap <A-f> :NvimTreeToggle<CR>
" ##################################################
" Use preset argument to open it
nnoremap <space>e :CocCommand explorer --root-strategies keep --no-quit-on-open<CR>

" <ALT> -----------------------------------

" movement 
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <A-J> <C-w>-
nnoremap <A-K> <C-w>+
nnoremap <A-L> <C-w>>
nnoremap <A-H> <C-w><

" <CTRL> -----------------------------------
" Better scroll in floating windows
inoremap <silent><nowait><expr> <C-J> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-K> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Coc Use <c-space> to trigger completion. 
inoremap <silent><expr> <c-space> coc#refresh()

" Comfortable motion
nnoremap <silent> <C-d> :call comfortable_motion#flick(40)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-40)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>

" Move text with ctrl
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" <KEYS> -----------------------------------
" yank to the end of line better
nnoremap Y y$

" Keep the screen centered when jumping
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Make relative jumps count in <C-o> and <C-i>
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Fast fold
nmap zuz <Plug>(FastFoldUpdate)

" Emmet
let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" Go to mark that doesn't conflict with Tmux
nnoremap 1 `

" turn terminal to normal mode with jj
inoremap jj <esc>
tnoremap jj <C-\><C-n>
tnoremap jq <C-\><C-n>:q<cr>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Make the change command copy to another register
nnoremap c "_c
vnoremap c "_c

" <Misc> -----------------------------------

" Highlight with cursor over
if exists('*CocActionAsync')
	augroup coc_settings
		autocmd!
		autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup END
endif

" Coc  Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Confirm on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Source init.vim in save
au! bufwritepost init.vim :source $MYVIMRC

" Support for typescript syntax
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" turn of indent line in file explorer
autocmd BufWinEnter * :IndentLinesDisable
autocmd BufWinEnter *.py :IndentLinesEnable
autocmd BufWinEnter *.js :IndentLinesEnable
autocmd BufWinEnter *.ts :IndentLinesEnable
autocmd BufWinEnter *.tex :IndentLinesEnable
autocmd BufWinEnter *.json :IndentLinesEnable
autocmd BufWinEnter *.html :IndentLinesEnable
autocmd BufWinEnter *.css :IndentLinesEnable
autocmd BufWinEnter *.f90 :IndentLinesEnable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Terminal on neovim                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open terminal command
function! OpenTerminal()
	split term://zsh
	resize 10
	setlocal scrolloff=0
	setlocal nonumber
	setlocal nowrap
endfunction
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" to turn everything into tabs ==> :%s/  /\t/g
" to turn everything into tabs ==> set noet ci pi sts=0 sw=2 ts=2

"#####################################################################
"##################################   PYTHON   #######################
"#####################################################################
augroup python_files
	autocmd!
	" == simply fold ==
	autocmd FileType python setlocal textwidth=79                            " Limit in text length
	autocmd FileType python setlocal foldmethod=indent                       " Limit in text length
	autocmd FileType python nmap <silent> gd <Plug>(coc-definition)
	autocmd FileType python nmap <silent> gy <Plug>(coc-type-definition)
	autocmd FileType python nmap <silent> gi <Plug>(coc-implementation)
	autocmd FileType python nmap <silent> gr <Plug>(coc-references)
	autocmd FileType python highlight NonText guifg=#636363
	" Execute command
	autocmd FileType python nnoremap <buffer> <silent> <leader>j :w<CR> :AsyncRun kitty --working-directory %:p:h --hold -e zsh -c "python %:p" &<CR>
augroup END

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

"#####################################################################
"##############################   MARK DOWN   ########################
"#####################################################################

augroup markdown_files
	autocmd!
	autocmd FileType markdown setlocal nonumber
	autocmd FileType markdown setlocal wrap linebreak
	autocmd FileType markdown setlocal nofoldenable
	autocmd FileType markdown nmap <leader>g :Goyo<CR>
	autocmd FileType markdown nmap <leader>P :PencilSoft<CR>
	autocmd FileType markdown nmap <leader>p :PencilToggle<CR>
	autocmd FileType markdown nnoremap <leader>j :MarkdownPreview<CR>
augroup END

"#####################################################################
"##############################   LATEX       ########################
"#####################################################################

augroup latex_files
	autocmd!
	autocmd BufNewFile,BufRead *.tex setlocal copyindent
	autocmd BufNewFile,BufRead *.tex setlocal preserveindent
	autocmd BufNewFile,BufRead *.tex setlocal nonumber
	autocmd BufNewFile,BufRead *.tex setlocal wrap linebreak
	autocmd BufNewFile,BufRead *.tex nmap <leader>P :PencilSoft<CR>
	autocmd BufNewFile,BufRead *.tex nmap <leader>p :PencilToggle<CR>
	autocmd BufNewFile,BufRead *.tex nmap <buffer> <silent> <Leader>j :w<CR> :VimtexCompile<CR>                          
	autocmd BufNewFile,BufRead *.tex nmap <buffer> <silent> <Leader>v : VimtexView<CR>                                   
augroup END

"#####################################################################
"##############################   javascript  ########################
"#####################################################################
augroup javascript_files
	autocmd!
	autocmd FileType javascript setlocal nowrap
	autocmd FileType javascript setlocal noexpandtab
	autocmd FileType javascript setlocal copyindent
	autocmd FileType javascript setlocal preserveindent
	autocmd FileType javascript setlocal softtabstop=0
	autocmd FileType javascript setlocal shiftwidth=2
	autocmd FileType javascript setlocal tabstop=2
	autocmd FileType javascript nmap <silent> gd <Plug>(coc-definition)
	autocmd FileType javascript nmap <silent> gy <Plug>(coc-type-definition)
	autocmd FileType javascript nmap <silent> gi <Plug>(coc-implementation)
	autocmd FileType javascript nmap <silent> gr <Plug>(coc-references)
	autocmd FileType javascript nnoremap <buffer> <silent> <leader>j :w<CR> :AsyncRun kitty --working-directory %:p:h --hold -e fish -c "node %:p" &<CR>
augroup END


"#####################################################################
"##############################   FORTRAN     ########################
"#####################################################################

augroup fortran_files
	autocmd!
	autocmd FileType fortran setlocal nowrap
	autocmd FileType fortran setlocal expandtab
	autocmd FileType fortran setlocal copyindent
	autocmd FileType fortran setlocal preserveindent
	autocmd FileType fortran setlocal softtabstop=0
	autocmd FileType fortran setlocal shiftwidth=2
	autocmd FileType fortran setlocal tabstop=2
	autocmd FileType fortran nnoremap <buffer> <silent> <leader>j :w<CR> :AsyncRun kitty --hold -e zsh -c "gfortran %:p -o exe && ./exe" &<CR>
augroup END


"#####################################################################
"##############################   MATLAB      ########################
"#####################################################################

augroup matlab_files
	autocmd!
	autocmd BufNewFile,BufRead *.m setlocal nowrap
	autocmd BufNewFile,BufRead *.m setlocal expandtab
	autocmd BufNewFile,BufRead *.m setlocal copyindent
	autocmd BufNewFile,BufRead *.m setlocal preserveindent
	autocmd BufNewFile,BufRead *.m setlocal softtabstop=0
	autocmd BufNewFile,BufRead *.m setlocal shiftwidth=2
	autocmd BufNewFile,BufRead *.m setlocal tabstop=2
	autocmd BufNewFile,BufRead *.m nnoremap <buffer> <silent> <leader>j :AsyncRun kitty --working-directory %:p:h --hold -e fish -c '/usr/local/MATLAB/R2018a/bin/matlab -nodesktop -nosplash -r "%:p:t:r;exit"' &<CR>
augroup END


"#####################################################################
"##############################   html css    ########################
"#####################################################################

augroup html_files
	autocmd!
	autocmd BufNewFile,BufRead *.html setlocal nowrap
	autocmd BufNewFile,BufRead *.html setlocal expandtab
	autocmd BufNewFile,BufRead *.html setlocal copyindent
	autocmd BufNewFile,BufRead *.html setlocal preserveindent
	autocmd BufNewFile,BufRead *.html setlocal softtabstop=0
	autocmd BufNewFile,BufRead *.html setlocal shiftwidth=2
	autocmd BufNewFile,BufRead *.html setlocal tabstop=2
augroup END

augroup css_files
	autocmd!
	autocmd BufNewFile,BufRead *.css setlocal nowrap
	autocmd BufNewFile,BufRead *.css setlocal noexpandtab
	autocmd BufNewFile,BufRead *.css setlocal copyindent
	autocmd BufNewFile,BufRead *.css setlocal preserveindent
	autocmd BufNewFile,BufRead *.css setlocal softtabstop=0
	autocmd BufNewFile,BufRead *.css setlocal shiftwidth=2
	autocmd BufNewFile,BufRead *.css setlocal tabstop=2
augroup END



"#####################################################################
"##################################    GODOT   #######################
"#####################################################################
augroup godot_script
	autocmd!
	autocmd BufNewFile,BufRead *.gd setlocal textwidth=79                            " Limit in text length
	autocmd BufNewFile,BufRead *.gd setlocal foldmethod=indent                       " Limit in text length
	autocmd BufNewFile,BufRead *.gd nmap <silent> gd <Plug>(coc-definition)
	autocmd BufNewFile,BufRead *.gd nmap <silent> gy <Plug>(coc-type-definition)
	autocmd BufNewFile,BufRead *.gd nmap <silent> gi <Plug>(coc-implementation)
	autocmd BufNewFile,BufRead *.gd nmap <silent> gr <Plug>(coc-references)
	autocmd BufNewFile,BufRead *.gd highlight NonText guifg=#636363
	" Execute command
	autocmd BufNewFile,BufRead *.gd nnoremap <buffer> <silent> <leader>j :w<CR> :GodotRun<CR>
	autocmd BufNewFile,BufRead *.gd nnoremap <buffer> <silent> <leader>J :w<CR> :GodotRunFZF<CR>
augroup END


"#####################################################################
"##################################  MISC   ##########################
"#####################################################################

" nvim-telescope ----
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_prefix = ">",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		scroll_strategy = "cycle",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter =  require('telescope.sorters').get_fzy_sorter,
		file_ignore_patterns = {},
		path_display = true,
		winblend = 0,
		layout_config = {
			width = 0.9,
			prompt_position = "bottom",
			preview_cutoff = 10,
		},
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
		color_devicons = true,
		use_less = true,
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
			},
		},
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}
	}
}
require('telescope').load_extension('fzy_native')
EOF
