-- Plugin management with vim-plug
vim.cmd([[
call plug#begin()

" List your plugins here
Plug 'niklasl/vim-rdf'
Plug 'tpope/vim-sensible'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mfussenegger/nvim-jdtls'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'griffin-rickle/vim-sparql-query', {'branch': 'feature/lua'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'NeogitOrg/neogit'
Plug 'mfussenegger/nvim-dap-python'
Plug 'pmizio/typescript-tools.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'z0mbix/vim-shfmt'
Plug 'kylechui/nvim-surround'
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'
Plug 'ful1e5/onedark.nvim'
Plug 'LunarVim/bigfile.nvim'
Plug 'niuiic/core.nvim'
Plug 'niuiic/dap-utils.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'

call plug#end()
]])

-- Colorscheme
vim.cmd('colorscheme onedark')

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
vim.cmd('syntax on')

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
    pattern = 'javascript',
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = augroup,
    pattern = '*.sq',
    callback = function()
        vim.bo.syntax = 'sparql'
        vim.bo.commentstring = '#%s'
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
keymap('n', '<Leader>qb', '<Cmd>lua require("sparql_query").run_with_config_from_range()<CR>', opts)

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

-- Telescope mappings
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
keymap('n', '<leader>fi', '<cmd>Telescope lsp_implementations<cr>', opts)
keymap('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', opts)
keymap('n', '<leader>fd', '<cmd>Telescope lsp_definitions<cr>', opts)

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

-- Load Lua configs
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true
    }
})
