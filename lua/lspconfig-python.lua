-- PYLSP COMMAND SHOULD BE COMING FROM ENVIRONMENT, IF asdfvm AND direnv ARE SET UP CORRECTLY
vim.lsp.config.pylsp = {
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
                    report_progress = false
                    -- dmypy = true,
                },
                -- jedi = { environment = vim.fn.exepath('python3') },
                -- auto-completion options
                jedi_completion = { fuzzy = true },
                -- import sorting
                pyls_isort = { enabled = true },
                rope_autoimport = {
                    enabled = false,
                    memory = true,
                },
                rope_completion = {
                    enabled = false,
                },
            },
        },
    },
    flags = {
        debounce_text_changes = 200,
    },
}

vim.lsp.enable('pylsp')
