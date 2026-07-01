local ok, local_config = pcall(require, 'local')
if not ok then
    vim.notify("local.lua not found. CodeCompanion will not be configured.", vim.log.levels.WARN)
    return
end

require("codecompanion").setup({
  adapters = {
    http = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = { api_key = function() return local_config.anthropic_api_key end },
        })
      end,
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = { api_key = function() return local_config.openai_api_key end },
        })
      end,
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = { model = { default = local_config.ollama_model or "llama3" } },
        })
      end,
    },
  },
  interactions = {
    chat = { adapter = local_config.llm_default_adapter or "anthropic" },
    inline = { adapter = local_config.llm_default_adapter or "anthropic" },
  },
  display = {
    chat = { window = { layout = "vertical", width = 0.4 } },
  },
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap({ 'n', 'v' }, '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', opts)
keymap('v', '<leader>ca', '<cmd>CodeCompanionChat Add<cr>', opts)
keymap({ 'n', 'v' }, '<leader>ci', '<cmd>CodeCompanion<cr>', opts)
