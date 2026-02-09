local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. Turtle LSP will not be configured.", vim.log.levels.WARN)
    return {}
end

local util = require('lspconfig.util')
local bin_name = local_config.turtle_language_server
local cmd = { 'node', bin_name, '--stdio' }

local configs = require('lspconfig.configs')
if not configs.turtle then
  configs.turtle = {
    default_config = {
      cmd = cmd,
      filetypes = { 'turtle' },
      root_dir = util.find_git_ancestor or vim.fn.getcwd(),
      single_file_support = true,
      settings = { }
    }
  }
end

require('lspconfig').turtle.setup({})
