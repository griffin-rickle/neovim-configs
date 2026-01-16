-- Key mappings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

require('fzf-lua').setup({
  winopts = {
    height = 0.85,
    width = 0.80,
    row = 0.35,
    col = 0.50,
    border = 'rounded',
    preview = {
      layout = 'flex',
      flip_columns = 120,
      vertical = 'down:45%',
      horizontal = 'right:50%',
      hidden = 'nohidden',
    },
  },

  keymap = {
    builtin = {
      ['<C-j>'] = 'down',
      ['<C-k>'] = 'up',
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
    },
  },
  fzf_opts = {
    ['--layout'] = 'default',
  },
})

-- Keymaps
local fzf = require('fzf-lua')
keymap('n', '<leader>ff', fzf.files, opts)
keymap('n', '<leader>fg', fzf.live_grep, opts)
keymap('n', '<leader>fb', fzf.buffers, opts)
keymap('n', '<leader>fh', fzf.help_tags, opts)
keymap('n', '<leader>fd', fzf.lsp_definitions, opts)
keymap('n', '<leader>fr', fzf.lsp_references, opts)
keymap('n', '<leader>fi', fzf.lsp_implementations, opts)
keymap('n', '<leader>fq', fzf.quickfix, opts)
