local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. SHACL LSP will not be configured.", vim.log.levels.WARN)
    return {}
end

local util = require('lspconfig.util')
local bin_name = local_config.shacl_language_server
local cmd = { 'node', bin_name, '--stdio' }

local configs = require('lspconfig.configs')
if not configs.shacl then
  configs.shacl = {
    default_config = {
      cmd = cmd,
      filetypes = { 'shacl', 'ttl' },  -- SHACL is often in Turtle format
      root_dir = util.find_git_ancestor or vim.fn.getcwd(),
      single_file_support = true,
      settings = { }
    }
  }
end

require('lspconfig').shacl.setup({})
