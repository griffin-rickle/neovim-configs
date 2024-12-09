local util = require('lspconfig.util')

local bin_name = '/home/grickle/.nvm/versions/node/v18.19.1/lib/node_modules/sparql-language-server'
local cmd = { 'node', bin_name, '--stdio' }
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
if not configs.sparql then
  return {
    default_config = {
      cmd = cmd,
      filetypes = { 'sparql' },
      root_dir = util.find_git_ancestor or vim.fn.getcwd(),
      single_file_support = true,
      settings = { }
    }
  }
end
