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

dap.adapters.tsnode = {
  type = 'executable',
  command = 'node',
  args = {
    vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'
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
            runtimeArgs = { '--loader=ts-node/esm', '--no-warnings', "--experimental-specifier-resolution=node" },
            program = "${file}",
            runtimeExecutable = 'node',
            -- args = { '${file}' },
            args = function()
              local input = vim.fn.input("Args: ")
              return vim.fn.split(input, " ", true)
            end,
            sourceMaps = true,
            protocol = 'inspector',
            outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
            resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
            },
            env = {
                NODE_NO_WARNINGS = "1"
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
            envFile = "${workspaceFolder}/.env",
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
        },
        {
          name = "[GAMUT] Launch GaMUt",
          type = "tsnode",
          request = "launch",
          program = "/home/grickle/git/stardog_config/tools/gamut/src/gamut.ts",
          cwd = vim.fn.getcwd(),
          runtimeExecutable = "ts-node",
          runtimeArgs = { "--esm" },
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          protocol = "inspector",
          console = "integratedTerminal",
          -- resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
    }
end
