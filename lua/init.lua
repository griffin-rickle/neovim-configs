require("bash-config")
require("bigfile-config")
require("dapui-config")
require("dap-java-config")
require("dap-js-config")
require("dap-python-config")
require("indent-blankline-config")
require("lspconfig-python")
require("onedark-config")
require("neogit-config")
require("nvim-tree-config")
require("nvim-treesitter-config")
require("python-config")
require("sparql-config")
require("surround-config")
require("telescope-config")

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
