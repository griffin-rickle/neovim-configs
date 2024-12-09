vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { '/home/grickle/.nvm/versions/node/v18.19.1/bin/bash-language-server', 'start' },
    })
  end,
})
