local ok, local_dap_configs = pcall(require, 'local-dap')
if not ok then
    vim.notify("local.lua not found. Java DAP configurations will use defaults.", vim.log.levels.WARN)
    local_dap_configs = { python = { } }
end

local dap = require('dap')

root_dir = require('lspconfig.util').root_pattern(".git")(0)
if root_dir then
    python_env = root_dir .. "/venv/bin/python" 
    if vim.fn.executable(python_env) == 0 then
        vim.notify("venv not found. Falling back to global python. Run: python -m venv venv to use local python", vim.log.levels.WARN)
        python_env = "python"
    end
end

require("dap-python").setup(python_env)
dap.configurations.python = local_dap_configs.python
