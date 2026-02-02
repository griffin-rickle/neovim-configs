-- Needed Installations:
-- rustup
-- rustup component add rust-analyzer
-- codelldb install (latest release from https://github.com/vadimcn/codelldb/releases)
-- $# Download 
-- $ mkdir -p ~/.local/share/nvim/codelldb
-- $ cd ~/.local/share/nvim/codelldb
-- $ mv ~/Downloads/codelldb-*.vsix .
-- $ unzip codelldb-*.vsix
-- $ chmod +x extension/adapter/codelldb

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function custom_attach(client, bufnr)
    local opts = { silent = true, buffer = bufnr }
    
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
end

-- Find rust-analyzer in rustup toolchain or use global
local rust_analyzer_cmd = "rust-analyzer"
local rustup_home = vim.env.RUSTUP_HOME or (vim.env.HOME .. "/.rustup")
local toolchain_rust_analyzer = rustup_home .. "/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer"

if vim.fn.executable(toolchain_rust_analyzer) == 1 then
    rust_analyzer_cmd = toolchain_rust_analyzer
elseif vim.fn.executable("rust-analyzer") == 0 then
    vim.notify("rust-analyzer not found. Install with: rustup component add rust-analyzer", vim.log.levels.ERROR)
    return
end

vim.lsp.config.rust_analyzer = {
    cmd = { rust_analyzer_cmd },
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
            },
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
        },
    },
    flags = {
        debounce_text_changes = 150,
    },
}

vim.lsp.enable('rust_analyzer')

-- Auto-format on save for Rust files
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
