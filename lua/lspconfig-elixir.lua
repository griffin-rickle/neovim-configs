local dap = require('dap')
dap.adapters.mix_task = {
  type = 'executable',
  command = vim.fn.expand("~/.local/share/nvim/mason/bin/elixir-ls-debugger"),
  args = {},
}
dap.configurations.elixir = {
  {
    type = "mix_task",
    name = "mix test",
    task = "test",
    taskArgs = { "--trace" },
    request = "launch",
    projectDir = "${workspaceFolder}",
    startApps = true,
    requireFiles = {
      "test/**/test_helper.exs",
      "test/**/*_test.exs"
    }
  },
}
