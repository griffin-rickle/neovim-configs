local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. SPARQL LSP will not be configured.", vim.log.levels.WARN)
    return
end

vim.filetype.add({
 extension = {
   sq = 'sparql'
 },
})

vim.lsp.sparql = {
  cmd = { "node", local_config.sparql_language_server, "--stdio" },
  capabilities=capabilities,
  on_attach = on_attach
}

