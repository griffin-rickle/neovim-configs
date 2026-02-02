-- LaTeX Configuration for Neovim
-- This file configures VimTeX for LaTeX editing with live preview

-- VimTeX configuration
-- PDF viewer - choose based on your OS:
-- Linux: 'zathura' or 'sioyek' or 'evince'
-- macOS: 'skim'
-- Windows: 'sumatrapdf'
vim.g.vimtex_view_method = 'zathura'

-- Compiler configuration
vim.g.vimtex_compiler_method = 'latexmk'

-- Enable continuous compilation (auto-compile on save)
vim.g.vimtex_compiler_latexmk = {
  build_dir = '',
  callback = 1,
  continuous = 1,
  executable = 'latexmk',
  options = {
    '-pdf',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}

-- Forward search configuration (jump to PDF location from source)
vim.g.vimtex_view_forward_search_on_start = 0

-- Concealment settings (hide LaTeX syntax for cleaner view)
vim.g.vimtex_syntax_conceal = {
  accents = 1,
  ligatures = 1,
  cites = 1,
  fancy = 1,
  spacing = 1,
  greek = 1,
  math_bounds = 0,
  math_delimiters = 1,
  math_fracs = 1,
  math_super_sub = 1,
  math_symbols = 1,
  sections = 0,
  styles = 1,
}

-- Quickfix window settings
vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_quickfix_open_on_warning = 0

-- Disable overfull/underfull warnings in quickfix
vim.g.vimtex_quickfix_ignore_filters = {
  'Underfull',
  'Overfull',
  'specifier changed to',
  'Token not allowed in a PDF string',
}

-- Enable TOC (table of contents)
vim.g.vimtex_toc_config = {
  name = 'TOC',
  layers = {'content', 'todo', 'include'},
  split_width = 30,
  todo_sorted = 0,
  show_help = 1,
  show_numbers = 1,
}

-- Fold settings for LaTeX
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_fold_types = {
  markers = { enabled = 0 },
  sections = { 
    parse_levels = 1,
    sections = {
      'part',
      'chapter',
      'section',
      'subsection',
      'subsubsection',
    },
  },
}

-- LaTeX-specific key mappings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- VimTeX specific mappings
keymap('n', '<leader>ll', '<cmd>VimtexCompile<cr>', vim.tbl_extend('force', opts, { desc = 'Toggle continuous compilation' }))
keymap('n', '<leader>lv', '<cmd>VimtexView<cr>', vim.tbl_extend('force', opts, { desc = 'View PDF' }))
keymap('n', '<leader>lc', '<cmd>VimtexClean<cr>', vim.tbl_extend('force', opts, { desc = 'Clean auxiliary files' }))
keymap('n', '<leader>le', '<cmd>VimtexErrors<cr>', vim.tbl_extend('force', opts, { desc = 'Show errors' }))
keymap('n', '<leader>lt', '<cmd>VimtexTocToggle<cr>', vim.tbl_extend('force', opts, { desc = 'Toggle table of contents' }))
keymap('n', '<leader>ls', '<cmd>VimtexStatus<cr>', vim.tbl_extend('force', opts, { desc = 'Show compilation status' }))
keymap('n', '<leader>lk', '<cmd>VimtexStop<cr>', vim.tbl_extend('force', opts, { desc = 'Stop compilation' }))
keymap('n', '<leader>lw', '<cmd>VimtexCountWords<cr>', vim.tbl_extend('force', opts, { desc = 'Count words' }))

-- Auto commands for LaTeX files
local latex_group = vim.api.nvim_create_augroup('LaTeXConfig', { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = latex_group,
  pattern = "tex",
  callback = function()
    -- Enable word wrap for LaTeX files
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    
    -- Set up auto-save on text change (optional, but useful for live preview)
    -- Uncomment the following block if you want auto-save
    --[[
    vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
      buffer = 0,
      callback = function()
        if vim.bo.modified then
          vim.cmd('silent! write')
        end
      end,
    })
    ]]
  end,
})

-- Optional: Set up LSP for LaTeX if texlab is installed
-- Uncomment and configure if you want LSP features
--[[
local lspconfig = require('lspconfig')
lspconfig.texlab.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
    },
  },
})
]]
