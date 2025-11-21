local ok, local_dap_configs = pcall(require, 'local-dap')
if not ok then
    vim.notify("local.lua not found. Java DAP configurations will use defaults.", vim.log.levels.WARN)
    local_dap_configs = { java = { } }
end

local dap = require('dap')
dap.configurations.java = local_dap_configs.java
