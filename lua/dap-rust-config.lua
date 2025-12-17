local ok, local_dap_configs = pcall(require, 'local-dap')
if not ok then
    vim.notify("local-dap.lua not found. Rust DAP configurations will use defaults.", vim.log.levels.WARN)
    local_dap_configs = { rust = {} }
end

local dap = require('dap')

-- Find codelldb
local codelldb_path = vim.fn.expand('~/.local/share/nvim/codelldb/extension/adapter/codelldb')

-- Check common locations for codelldb
if vim.fn.executable(codelldb_path) == 0 then
    local alt_paths = {
        vim.fn.expand('~/.vscode/extensions/vadimcn.vscode-lldb-*/adapter/codelldb'),
        '/usr/bin/codelldb',
        vim.fn.expand('~/bin/codelldb'),
    }
    
    for _, path in ipairs(alt_paths) do
        local expanded = vim.fn.glob(path)
        if expanded ~= '' and vim.fn.executable(expanded) == 1 then
            codelldb_path = expanded
            break
        end
    end
end

if vim.fn.executable(codelldb_path) == 0 then
    vim.notify(
        "codelldb not found. Install from: https://github.com/vadimcn/codelldb/releases\n" ..
        "Extract to: ~/.local/share/nvim/codelldb/",
        vim.log.levels.WARN
    )
    codelldb_path = 'codelldb'  -- Fallback to PATH
end

-- Configure codelldb adapter
dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = {"--port", "${port}"},
    }
}

-- Default Rust configurations
local default_rust_configs = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
            -- Build the project first
            vim.notify("Building Rust project...", vim.log.levels.INFO)
            local build_result = vim.fn.system("cargo build 2>&1")
            
            if vim.v.shell_error ~= 0 then
                vim.notify("Build failed:\n" .. build_result, vim.log.levels.ERROR)
                return nil
            end
            
            vim.notify("Build successful!", vim.log.levels.INFO)
            
            -- Try to find the binary in target/debug
            local cwd = vim.fn.getcwd()
            local cargo_toml = cwd .. "/Cargo.toml"
            
            if vim.fn.filereadable(cargo_toml) == 1 then
                -- Parse Cargo.toml to get package name
                local cargo_content = vim.fn.readfile(cargo_toml)
                local package_name = nil
                
                for _, line in ipairs(cargo_content) do
                    local name_match = line:match('^name%s*=%s*"([^"]+)"')
                    if name_match then
                        package_name = name_match
                        break
                    end
                end
                
                if package_name then
                    local debug_bin = cwd .. '/target/debug/' .. package_name
                    if vim.fn.executable(debug_bin) == 1 then
                        return debug_bin
                    end
                end
            end
            
            -- Fallback to user input
            return vim.fn.input('Path to executable: ', cwd .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
    {
        name = "Launch with args",
        type = "codelldb",
        request = "launch",
        program = function()
            -- Build the project first
            vim.notify("Building Rust project...", vim.log.levels.INFO)
            local build_result = vim.fn.system("cargo build 2>&1")
            
            if vim.v.shell_error ~= 0 then
                vim.notify("Build failed:\n" .. build_result, vim.log.levels.ERROR)
                return nil
            end
            
            vim.notify("Build successful!", vim.log.levels.INFO)
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " ")
        end,
        runInTerminal = false,
    },  {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = function()
            return tonumber(vim.fn.input('Process ID: '))
        end,
        cwd = '${workspaceFolder}',
    },
}

-- Merge with local configurations if they exist
if local_dap_configs.rust and #local_dap_configs.rust > 0 then
    dap.configurations.rust = local_dap_configs.rust
else
    dap.configurations.rust = default_rust_configs
end
