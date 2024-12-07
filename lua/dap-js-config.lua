require('typescript-tools').setup {
    settings={}
}

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/home/grickle/git/vscode-js-debug/", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "debug concourse server",
            restart = true,
            runtimeExecutable = '${workspaceFolder}/node_modules/.bin/nodemon',
            program = "${workspaceFolder}/src/server.js",
            cwd = "${workspaceFolder}",
            skipFiles = { '<node_indernals>/**' },
            args = { '-e js,graphql', '--watch src/server', '--watch src/server.js' },
        },
        {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Debug localhost:3000',
            url = 'localhost:3000',
            webRoot = '${workspaceFolder}'
        },
        {
            type = 'pwa-node',
            name = 'run npm start:client',
            request = 'launch',
            runtimeArgs = { '--host', '127.0.0.1', '--config', '${workspaceFolder}/webpack.local.js' },
            runtimeExecutable = '${workspaceFolder}/node_modules/.bin/webpack-dev-server',
            -- skipFiles = { '<node_internals>/**' }
        }
    }
end

