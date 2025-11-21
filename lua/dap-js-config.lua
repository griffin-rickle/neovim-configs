local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. JavaScript DAP will use defaults.", vim.log.levels.WARN)
    local_config = { 
        js_debug_path = vim.fn.stdpath("data") .. "/js-debug/src/dapDebugServer.js",
    }
end

local projects_ok, local_js_projects = pcall(require, 'local-dap')
if not projects_ok then
    vim.notify("local-dap.lua not found. No JS projects set up for debugging", vim.log.levels.WARN)
    local_js_projects = { javascript = { } }
end


local dap = require('dap')

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}", --let both ports be the same for now...
    executable = {
        command = "node",
        args = { local_config.js_debug_path, "${port}" },
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
    dap.configurations[language] = local_js_projects.javascript
end
