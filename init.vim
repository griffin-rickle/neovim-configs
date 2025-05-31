call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'joshdick/onedark.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-tree/nvim-tree.lua'

Plug 'neovim/nvim-lspconfig'
Plug 'christoomey/vim-tmux-navigator'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'mfussenegger/nvim-jdtls'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'

"Plug 'griffin-rickle/vim-sparql-query'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'kyazdani42/nvim-web-devicons'

Plug 'NeogitOrg/neogit'

Plug 'mfussenegger/nvim-dap-python'

Plug 'pmizio/typescript-tools.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'OXY2DEV/markview.nvim'


Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'z0mbix/vim-shfmt'

Plug 'kylechui/nvim-surround'

Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'
Plug 'ful1e5/onedark.nvim'

Plug 'LunarVim/bigfile.nvim'

Plug 'niuiic/core.nvim'
Plug 'niuiic/dap-utils.nvim'
call plug#end()
"colorscheme onedark

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set colorcolumn=100

let g:syntastic_python_python_exec = 'python3'

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
" set number
" set relativenumber
set clipboard+=unnamedplus
set noswapfile
set hlsearch
set ignorecase
set incsearch

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap jj <ESC>
let mapleader="\\"

" source ~/git/vim-sparql/syntax/sparql.vim
" source ~/git/vim-sparql/ftdetect/sparql.vim
" source ~/git/vim-rdf/syntax/trig.vim
" source ~/git/vim-rdf/syntax/jsonld.vim
" source ~/git/vim-rdf/syntax/n3.vim
" source ~/git/vim-rdf/syntax/turtle.vim

autocmd StdinReadPre * let g:isReadingFromStdin = 1

set nofoldenable

nmap <Leader>p <Nop>

nmap <Leader>qb :BufferQuery<CR>

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>

let g:ale_linters = {
    \   'python': ['flake8', 'plint'],
    \   'clojure': ['clj-kondo'],
    \}

let g:pymode_options_max_line_length = 120 
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1

autocmd FileType javascript setlocal ts=2 sts=2 sw=2
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

nnoremap <silent> <C-b> :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <C-g>g :call FZFOpen(':Ag')<CR>
nnoremap <silent> <C-g>c :call FZFOpen(':Commands')<CR>
nnoremap <silent> <C-g>l :call FZFOpen(':BLines')<CR>
nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>
syntax on
filetype plugin indent on

autocmd BufNewFile,BufRead *.sq set syntax=sparql | setlocal commentstring=#%s

let g:python3_host_prog=$HOME.'/.pyenv/shims/python3'

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
"let g:mkdp_theme = 'dark'

nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>

nnoremap <leader>h :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>dk :lua require'dap'.continue()<CR>
nnoremap <leader>dj :lua require'dap'.step_over()<CR>
nnoremap <leader>dl :lua require'dap'.step_into()<CR>
nnoremap <leader>dt :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>de :lua require'dap'.disconnect({ terminateDebuggee = true })<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>

nnoremap <leader>do :lua require'dapui'.toggle()<CR>

nnoremap <leader>ng :Neogit<CR>

nnoremap <leader>lo :lua vim.diagnostic.open_float()<CR>

nnoremap <leader>af :lua vim.g.py_auto_format=1<CR>
nnoremap <leader>an :lua vim.g.py_auto_format=0<CR>

nnoremap <leader>cb :lua require("qf-diff").diff()<CR>
nnoremap <leader>cn :lua require("qf-diff").next()<CR>
nnoremap <leader>cp :lua require("qf-diff").prev()<CR>

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

lua require('init')
lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}

