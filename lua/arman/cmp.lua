local cmp = require 'cmp'
cmp.setup {
    snippet = {
        -- snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-10),
        ['<C-f>'] = cmp.mapping.scroll_docs(10),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-k>'] = cmp.mapping.confirm { select = true },
    },
    sources = cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        --{ name = 'cmdline' },
        { name = 'path' },
    }, {
        { name = 'buffer' },
    }),
}
