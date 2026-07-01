local ok, local_dap_configs = pcall(require, 'local-dap')
if not ok then
    vim.notify("local.lua not found. Python DAP configurations will use defaults.", vim.log.levels.WARN)
    local_dap_configs = { python = { } }
end

local dap = require('dap')

root_dir = require('lspconfig.util').root_pattern(".git")(0)
if root_dir then
    python_env = root_dir .. "/venv/bin/python" 
    if vim.fn.executable(python_env) == 0 then
        python_env = "python"
    end
end

require("dap-python").setup(python_env)
if local_dap_configs.python and #local_dap_configs.python > 0 then
    for _, config in ipairs(local_dap_configs.python) do
        table.insert(dap.configurations.python, config)
    end
end
