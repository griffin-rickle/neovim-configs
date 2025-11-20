root_dir = require('lspconfig.util').root_pattern(".git")(0)

if root_dir then
    python_env = root_dir .. "/venv/bin/pylsp" 
    if vim.fn.executable(python_env) == 0 then
        vim.notify("pylsp not found in venv. Falling back to global pylsp. Run: pip install -e '.[dev]' to use local pylsp", vim.log.levels.WARN)
        python_env = "pylsp"
    end
end

vim.lsp.config.pylsp = {
    cmd = { python_env },
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                -- formatter options
                black = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                -- linter options
                -- pylint = { enabled = true, executable = "pylint" },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                -- type checker
                pylsp_mypy = {
                    enabled = true,
                    strict = true,
                },
                -- auto-completion options
                jedi_completion = { fuzzy = true },
                -- import sorting
                pyls_isort = { enabled = true },
                rope_autoimport = {
                    enabled = true,
                    memory = true,
                },
                rope_completion = {
                    enabled = true,
                },
            },
        },
    },
    flags = {
        debounce_text_changes = 200,
    },
}

vim.lsp.enable('pylsp')
