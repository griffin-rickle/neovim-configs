local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. SPARQL LSP will not be configured.", vim.log.levels.WARN)
    return
end

vim.lsp.sparql = {
  cmd = { "node", local_config.sparql_language_server, "--stdio" },
  capabilities=capabilities,
  on_attach = on_attach
}

vim.filetype.add({
  extension = {
    sq = 'sparql',
    rq = 'sparql',
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sparql",
  callback = function()
    vim.bo.commentstring = "# %s"
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_loaded(bufnr) then
        local parser = vim.treesitter.get_parser(0, "sparql")
        if parser then
          vim.treesitter.highlighter.new(parser)
        end
    end
  end,
})

