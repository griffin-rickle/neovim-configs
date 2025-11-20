-- COMMENTED BECAUSE Shopify.ruby_lsp is not compatible with JRuby 9.4.2.0 (need 9.4.6.0)
vim.lsp.config.ruby_lsp = {
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
  },
}
