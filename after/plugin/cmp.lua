
local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
    return
end

local luasnip = require('luasnip')

cmp.setup({

    -- MUST specify a snippet engine
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- have to do it this way otherwise it messes with my tabs for some reason
        ['<C-o>'] = cmp.mapping.select_prev_item(),
        ['<C-i>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<S-CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-p>'] = cmp.mapping.confirm({ select = true }), -- here so I can overwrite this mapping on Windows Terminal


    }),
    sources = cmp.config.sources({
        {name = 'nvim_lua'},
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
        {name = 'path'},
        {name = 'buffer', keyword_length = 4},
        {name = 'text', keyword_length = 4},
        {name = 'Text', keyword_length = 4},
    }),

    experimental = {
        ghost_text = true,
    },

    -- TODO look into "formatting"
})
