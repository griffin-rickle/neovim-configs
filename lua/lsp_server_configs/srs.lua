local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. SRS LSP will not be configured.", vim.log.levels.WARN)
    return {}
end

local util = require('lspconfig.util')
local bin_name = local_config.srs_language_server
local cmd = { 'node', bin_name, '--stdio' }

local configs = require('lspconfig.configs')
if not configs.srs then
  configs.srs = {
    default_config = {
      cmd = cmd,
      filetypes = { 'srs' },
      root_dir = util.find_git_ancestor or vim.fn.getcwd(),
      single_file_support = true,
      settings = { }
    }
  }
end

require('lspconfig').srs.setup({})
