require("bash-config")
require("bigfile-config")
require("dapui-config")
require("dap-java-config")
require("dap-js-config")
require("dap-python-config")
require("indent-blankline-config")
require("lspconfig-elixir")
require("lspconfig-python")
require("onedark-config")
require("neogit-config")
require("nvim-tree-config")
require("nvim-treesitter-config")
require("python-config")
require("sparql-config")
require("surround-config")
require("telescope-config")

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "elixirls",
        "clojure_lsp",
        "jedi_language_server",
        "bashls",
        "ts_ls",
        "eslint"
    }
})

-- Autocompletion setup (nvim-cmp)
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Setup lspconfig with capabilities
local lspconfig = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  elixirls = {
    cmd = { "elixir-ls" },
  },
  clojure_lsp = {},
  jedi_language_server = {},
  bashls = {},
  tsserver = {},
  eslint = {},
}

for server, config in pairs(servers) do
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end

function bufoptsWithDesc(desc)
    return { silent = true, buffer = bufnr, desc = desc }
end

vim.keymap.set("n", "<leader>r", function()
  -- when rename opens the prompt, this autocommand will trigger
  -- it will "press" CTRL-F to enter the command-line window `:h cmdwin`
  -- in this window I can use normal mode keybindings
  local cmdId
  cmdId = vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
      callback = function()
        local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
        vim.api.nvim_feedkeys(key, "c", false)
        vim.api.nvim_feedkeys("0", "n", false)
        -- autocmd was triggered and so we can remove the ID and return true to delete the autocmd
        cmdId = nil
        return true
      end,
    })
  vim.lsp.buf.rename()
  -- if LPS couldn't trigger rename on the symbol, clear the autocmd
  vim.defer_fn(function()
      -- the cmdId is not nil only if the LSP failed to rename
      if cmdId then
        vim.api.nvim_del_autocmd(cmdId)
      end
    end, 500)
end, bufoptsWithDesc("Rename symbol"))

-- vim.cmd([[autocmd! CursorHold * :lua vim.lsp.buf.hover()]])

vim.opt.mouse = ""

vim.opt.swapfile = true

vim.diagnostic.config({
  float = {
    source = 'always',
    border = border
  },
})
