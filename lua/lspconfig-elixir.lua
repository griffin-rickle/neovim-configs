local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.elixirls = {
    cmd = { 'elixir-ls' },
    filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
    root_markers = { 'mix.exs', '.git' },
    capabilities = capabilities,
    settings = {
        elixirLS = {
            dializerEnabled = false,
            fetchDeps = false,
        }
    }

}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'elixir', 'eelixir', 'heex', 'surface' },
  callback = function()
    vim.lsp.enable('elixirls')
  end,
})
