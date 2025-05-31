require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "java", "python", "javascript", "typescript", "tsx", "markdown", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
  },
  autopairs = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  textobjects = {
    enable = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["aC"] = "@class.outer",
      ["iC"] = "@class.inner",
      ["ac"] = "@conditional.outer",
      ["ic"] = "@conditional.inner",
      ["ae"] = "@block.outer",
      ["ie"] = "@block.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["is"] = "@statement.inner",
      ["as"] = "@statement.outer",
      ["ad"] = "@comment.outer",
      ["am"] = "@call.outer",
      ["im"] = "@call.inner"
    }
  },
}

