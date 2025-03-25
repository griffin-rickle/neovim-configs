local dap = require('dap')

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}", --let both ports be the same for now...
    executable = {
        command = "node",
        -- -- 💀 Make sure to update this path to point to your installation
        args = { "/home/grickle/Downloads/js-debug-dap-v1.97.1/js-debug/src/dapDebugServer.js", "${port}" },
        -- command = "js-debug-adapter",
        -- args = { "${port}" },
    },
}

-- Need to have ts-node installed with npm; `npm i -g ts-node`
-- Not the best solution but if it allows me to debug JS I don't mind
for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (pwa-node)',
            cwd = "${workspaceFolder}", -- vim.fn.getcwd(),
            args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
        },
        {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (Typescript)',
            cwd = "${workspaceFolder}",
            runtimeArgs = { '--loader=ts-node/esm' },
            program = "${file}",
            runtimeExecutable = 'node',
            -- args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
            outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
            resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
            },
        },
        {
            type = 'pwa-node',
            request = 'launch',
            name = '[CONCOURSE] - Debug Server',
            sourceMaps = true,
            cwd = "${workspaceFolder}",
            runtimeExecutable = "/home/grickle/git/concourse/node_modules/nodemon/bin/nodemon.js",
            runtimeArgs = {
                "-e", "js,graphql",
                "--watch", "src/server",
                "--watch", "src/server.js"
            },
            program = "src/server.js"
        },
        {
            type = 'pwa-node',
            request = 'launch',
            name = '[ANNOUNCEBOT] - Debug Server',
            sourceMaps = true,
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            runtimeArgs = {
                "-r", "dotenv/config"
            },
            program = "server/index.js",
            args = { "dotenv_config_path=server/config/.announcebot.env" },
        }
    }
end
