require("sparql_query").setup({
    configs = {
        {
            name = "decomp local",
            endpoint = "http://127.0.0.1:5820",
            db = "decomp",
            user = "admin",
            pass = "hunter22",
            accept = "text/tab-separated-values",
            default = true
        },
        {
            name = "decomp local",
            endpoint = "http://127.0.0.1:5820",
            db = "compass",
            user = "admin",
            pass = "hunter22",
            accept = "text/tab-separated-values",
        }
    }
})
vim.keymap.set('n', '<Leader>qn', function()
    require('sparql_query').run_buffer_with_new_config()
end, { desc = "Run SPARQL query with new config selection" })

vim.keymap.set('n', '<Leader>ql', function()
    require('sparql_query').run_with_config_from_range(nil, nil, { auto_select = true })
end, { desc = "Run SPARQL query with last used config (auto)" })

require("bash-config")
require("bigfile-config")
require("cmp-config")
require("dapui-config")
require("dap-java-config")
require("dap-js-config")
require("dap-python-config")
require("indent-blankline-config")
require('lspconfig-clojure')
require('lspconfig-lua')
require("lspconfig-python")
require("lspconfig-ruby")
require("onedark-config")
require("neogit-config")
require("nvim-tree-config")
require("nvim-treesitter-config")
require("python-config")
require("sparql-config")
require("surround-config")
require("telescope-config")
require("typescript-tools-config")

require("mason").setup()

-- Common capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Bash
vim.lsp.config.bashls = {
  capabilities = capabilities,
}

-- Clojure
vim.lsp.config.clojure_lsp = {
  cmd = { vim.fn.expand("~/.local/share/nvim/mason/packages/clojure-lsp/clojure-lsp") },
  capabilities = capabilities,
}

-- ESLint
vim.lsp.config.eslint = {
  capabilities = capabilities,
}

-- TypeScript (was ts_ls, now tsserver in mason)
vim.lsp.config.ts_ls = {
  capabilities = capabilities,
}

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

vim.opt.mouse = ""

-- vim.opt.swapfile = true

vim.diagnostic.config({
  float = {
    source = 'always',
    border = border
  },
})

local jdtls = require('jdtls')

-- Setup keymap for organizing imports
vim.keymap.set('n', '<A-o>', function()
  jdtls.organize_imports()
end, { buffer = true, desc = "Organize Imports (Sort & Remove)" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.expandtab = true     -- Use spaces instead of tabs
    vim.opt_local.shiftwidth = 2       -- Number of spaces for indentation
    vim.opt_local.tabstop = 2          -- Number of spaces a tab counts for
    vim.opt_local.softtabstop = 2      -- Number of spaces for tab in insert mode
  end,
})

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
-- vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, opts)
vim.g.python3_host_prog = vim.fn.getcwd() .. '/venv/bin/python'
