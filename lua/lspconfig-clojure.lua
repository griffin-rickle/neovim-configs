local api = vim.api

api.nvim_create_autocmd('FileType', {
  pattern = {'clojure'},
  callback = function()
    local ok, local_config = pcall(require, 'local')
    if not ok then
        vim.notify("local.lua not found. Clojure LSP will not be configured.", vim.log.levels.ERROR)
        return
    end

    -- lspconfig-clojure.lua
    local lsp = vim.lsp

    -- Use the same capabilities you defined in your init.lua
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Check if the JAR file exists
    local jar_path = local_config.clojure_lsp_jar
    if not vim.loop.fs_stat(jar_path) then
      vim.notify("clojure-lsp JAR file not found at: " .. jar_path, vim.log.levels.ERROR)
    end


    local root_files = vim.fs.find({
      'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn',
      '.git'
    }, { upward = true })

    local root_dir
    if #root_files > 0 then
      root_dir = vim.fs.dirname(root_files[1])
    else
      root_dir = vim.fn.getcwd()
    end

    local cmd = { 'java', '-jar', jar_path }

    local server = lsp.start({
      name = 'clojure-lsp',
      cmd = cmd,
      capabilities = capabilities,
      root_dir = root_dir,
      handlers = {
        ["window/logMessage"] = function(err, result, ctx, config)
          local level = ({
            [1] = vim.log.levels.ERROR,
            [2] = vim.log.levels.WARN,
            [3] = vim.log.levels.INFO,
            [4] = vim.log.levels.DEBUG,
          })[result.type]
          vim.notify("[clojure-lsp] " .. result.message, level)
          return vim.lsp.handlers["window/logMessage"](err, result, ctx, config)
        end
      }
    })

    if server then
      vim.notify("Clojure LSP started successfully with client ID: " .. server, vim.log.levels.INFO)
    else
      vim.notify("Failed to start Clojure LSP", vim.log.levels.ERROR)
    end
  end,
  group = api.nvim_create_augroup('LspClojure', {}),
})
