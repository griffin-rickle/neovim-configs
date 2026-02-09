vim.opt.mouse=''
vim.cmd([[
call plug#begin()

Plug 'nvim-neotest/nvim-nio'

" Plenary 
Plug 'nvim-lua/plenary.nvim'

" CMP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-omni'

" fzf-lua
Plug 'ibhagwan/fzf-lua'

" Mason
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Sparql-specifics
Plug 'niklasl/vim-rdf'
Plug 'griffin-rickle/sq2md.nvim', {'branch': 'feature/lua'}

" LaTeX
Plug 'lervag/vimtex'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'v0.10.0', 'do': ':TSUpdate' }

"LSP Config
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'

" Git Stuff
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'niuiic/core.nvim'
Plug 'niuiic/dap-utils.nvim'

" Pickers
Plug 'nvim-telescope/telescope.nvim'

" UI / UX
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'ful1e5/onedark.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'LunarVim/bigfile.nvim'

" TMUX
Plug 'christoomey/vim-tmux-navigator'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Bash
Plug 'z0mbix/vim-shfmt'

" Typescript
Plug 'pmizio/typescript-tools.nvim'

" Keybinds
Plug 'kylechui/nvim-surround'
Plug 'tpope/vim-sensible'

" Lua
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Rust
Plug 'rust-lang/rust.vim'
call plug#end()
]])

require('lsp_server_configs.sparql')
require('lsp_server_configs.shacl')
require('lsp_server_configs.sms')
require('lsp_server_configs.srs')
require('lsp_server_configs.trig')
require('lsp_server_configs.turtle')
require('rdf-filetypes')
require("bash-config")
require("bigfile-config")
require("cmp-config")
require("dapui-config")
require("dap-java-config")
require("dap-js-config")
require("dap-python-config")
require("dap-rust-config")
require("indent-blankline-config")
require("latex-config")
require('lspconfig-clojure')
require('lspconfig-elixir')
require('lspconfig-lua')
require("lspconfig-python")
require("lspconfig-ruby")
require("lspconfig-rust")
require("onedark-config")
require("fzf-lua-config")
require("neogit-config")
require("nvim-tree-config")
require("nvim-treesitter-config")
require("python-config")
require("sparql-config")
require("surround-config")
require("telescope-config")
require("typescript-tools-config")

vim.keymap.set('n', '<Leader>qn', function()
    require('sq2md').choose_config_and_run(nil, nil)
end, { desc = "Run SPARQL query with new config selection" })

vim.keymap.set('n', '<Leader>ql', function()
    require('sq2md').run_with_last_config(nil, nil)
end, { desc = "Run SPARQL query with last used config (auto)" })

local ok, local_config = pcall(require, 'local')
local sparql_config = {}
if not ok then
    vim.notify("local.lua not found; no sq2md configs will be loaded!", vim.log.levels.WARN)
    sparql_config = {configs = {}}
else
    sparql_config = local_config.sparql_query_config
end
require("sq2md").setup(sparql_config)

-- Colorscheme
vim.cmd('colorscheme onedark')

require("mason").setup()

-- Common capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ESLint
vim.lsp.config.eslint = {
  capabilities = capabilities,
}

-- TypeScript (was ts_ls, now tsserver in mason)
vim.lsp.config.ts_ls = {
  capabilities = capabilities,
}

vim.lsp.enable({'eslint', 'ts_ls'})

function bufoptsWithDesc(desc)
    return { silent = true, buffer = bufnr, desc = desc }
end


-- Basic settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.colorcolumn = '100'
vim.opt.clipboard:append('unnamedplus')
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.foldenable = false

-- Filetype settings
vim.cmd('filetype plugin indent on')
-- vim.cmd('syntax on')

-- Leader key
vim.g.mapleader = '\\'

-- Global variables
vim.g.syntastic_python_python_exec = 'python3'
vim.g.pymode_lint_ignore = 'E501,W'
vim.g.syntastic_python_pylint_post_args = '--max-line-length=120'
vim.g.pymode_options_max_line_length = 120
vim.g.pymode_lint_options_pep8 = {max_line_length = 120}
vim.g.pymode_lint_options_flake8 = {max_line_length = 120}
vim.g.pymode_options_colorcolumn = 1

-- Markdown preview settings
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_open_ip = ''
vim.g.mkdp_browser = ''
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_browserfunc = ''
vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
    disable_filename = 0,
    toc = {}
}
vim.g.mkdp_markdown_css = ''
vim.g.mkdp_highlight_css = ''
vim.g.mkdp_port = ''
vim.g.mkdp_page_title = '「${name}」'
vim.g.mkdp_filetypes = {'markdown'}

-- Autocommands
local augroup = vim.api.nvim_create_augroup('MyAutoCommands', { clear = true })

vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter'}, {
    group = augroup,
    callback = function()
        if vim.wo.number and vim.fn.mode() ~= 'i' then
            vim.wo.relativenumber = true
        end
    end
})

vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave'}, {
    group = augroup,
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = false
        end
    end
})

vim.api.nvim_create_autocmd('StdinReadPre', {
    group = augroup,
    callback = function()
        vim.g.isReadingFromStdin = 1
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'python',
    callback = function()
        vim.b.ale_enabled = 0
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'typescript',
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'javascript',
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

-- Key mappings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable arrow keys
keymap('n', '<Up>', '<Nop>', opts)
keymap('n', '<Down>', '<Nop>', opts)
keymap('n', '<Left>', '<Nop>', opts)
keymap('n', '<Right>', '<Nop>', opts)

-- Quick escape
keymap('i', 'jj', '<ESC>', opts)

-- Leader mappings
keymap('n', '<Leader>p', '<Nop>', opts)

-- Vimux mappings
keymap('n', '<Leader>vp', ':VimuxPromptCommand<CR>', opts)
keymap('n', '<Leader>vl', ':VimuxRunLastCommand<CR>', opts)
keymap('n', '<Leader>vi', ':VimuxInspectRunner<CR>', opts)

-- FZF mappings
keymap('n', '<C-b>', ':Buffers<CR>', opts)
keymap('n', '<C-g>g', ':Ag<CR>', opts)
keymap('n', '<C-g>c', ':Commands<CR>', opts)
keymap('n', '<C-g>l', ':BLines<CR>', opts)
keymap('n', '<C-p>', ':Files<CR>', opts)

-- LSP mappings
keymap('n', '<leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<leader>lo', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- DAP mappings
keymap('n', '<leader>dk', '<Cmd>lua require("dap").continue()<CR>', opts)
keymap('n', '<leader>dj', '<Cmd>lua require("dap").step_over()<CR>', opts)
keymap('n', '<leader>dl', '<Cmd>lua require("dap").step_into()<CR>', opts)
keymap('n', '<leader>dt', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>de', '<Cmd>lua require("dap").disconnect({ terminateDebuggee = true })<CR>', opts)
keymap('n', '<leader>do', '<Cmd>lua require("dapui").toggle()<CR>', opts)

-- NvimTree mapping
keymap('n', '<leader>nt', ':NvimTreeToggle<CR>', opts)

-- Neogit mapping
keymap('n', '<leader>ng', ':Neogit<CR>', opts)

-- Python auto-format mappings
keymap('n', '<leader>af', '<Cmd>lua vim.g.py_auto_format=1<CR>', opts)
keymap('n', '<leader>an', '<Cmd>lua vim.g.py_auto_format=0<CR>', opts)

-- QF diff mappings
keymap('n', '<leader>cb', '<Cmd>lua require("qf-diff").diff()<CR>', opts)
keymap('n', '<leader>cn', '<Cmd>lua require("qf-diff").next()<CR>', opts)
keymap('n', '<leader>cp', '<Cmd>lua require("qf-diff").prev()<CR>', opts)

-- Force treesitter highlighting on
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    pcall(vim.treesitter.start)
  end
})
