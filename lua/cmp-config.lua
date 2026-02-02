local cmp = require'cmp'
local lspkind = require'lspkind'
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
      
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'omni' },  
    }, {
            { name = 'buffer' },
            { name = 'path' }
        }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50
        })
    },
    experimental = {
        ghost_text = true,
    },
    preselect = cmp.PreselectMode.Item,
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('tex', {
  sources = cmp.config.sources({
    { name = 'omni' },  -- VimTeX omni completion
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})
