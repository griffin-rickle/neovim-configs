vim.filetype.add({
 extension = {
   sq = 'sparql'
 },
})

vim.lsp.sparql = {
  cmd = { "node", "/home/grickle/.nvm/versions/node/v18.19.1/lib/node_modules/sparql-language-server", "--stdio" },
  capabilities=capabilities,
  on_attach = on_attach
}

