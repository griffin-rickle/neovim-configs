local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. RDF LSPs will not be configured.", vim.log.levels.WARN)
    return
end

-- Turtle
vim.lsp.turtle = {
  cmd = { "node", local_config.turtle_language_server, "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach
}

-- TriG
vim.lsp.trig = {
  cmd = { "node", local_config.trig_language_server, "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach
}

-- SMS
vim.lsp.sms = {
  cmd = { "node", local_config.sms_language_server, "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach
}

-- SRS
vim.lsp.srs = {
  cmd = { "node", local_config.srs_language_server, "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach
}

-- SHACL
vim.lsp.shacl = {
  cmd = { "node", local_config.shacl_language_server, "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach
}

-- Register filetypes
vim.filetype.add({
  extension = {
    ttl = 'turtle',
    trig = 'trig',
    sms = 'sms',
    srs = 'srs',
    shacl = 'shacl',
  }
})

-- Set comment strings for each filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "turtle", "trig", "sms", "srs", "shacl" },
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})
