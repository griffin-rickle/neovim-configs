local lspconfig = require('lspconfig')

lspconfig.elixirls.setup {
  cmd = { "/home/griff/git/elixir-ls/release/language_server.sh" }, -- change this
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
  on_attach = function(client, bufnr)
    -- You can add keybindings or other setup here if you want
  end,
}
