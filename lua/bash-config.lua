local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- lua/bash-config.lua
local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. Bash LSP will use system default.", vim.log.levels.WARN)
    local_config = { nvm_node_path = "" }
end

local bash_lsp_cmd = local_config.nvm_node_path ~= ""
    and local_config.nvm_node_path .. '/bin/bash-language-server'
    or 'bash-language-server'

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { bash_lsp_cmd, 'start' },
      capabilities = capabilities
    })
  end,
})
