vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.py",
        group = "AutoFormat",
        callback = function()
            if(vim.g.py_auto_format == 1)
            then
                vim.cmd("silent !black --quiet %")            
                vim.cmd("silent !isort --profile black %")
                vim.cmd("edit")
            end
        end,
    }
)
