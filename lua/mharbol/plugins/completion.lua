return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-buffer',       -- buffer completion (words from the current buffer)
        'hrsh7th/cmp-path',         -- path completion (files/filenames)
        'hrsh7th/cmp-nvim-lua',     -- has special nvim knowledge
        'hrsh7th/cmp-nvim-lsp',     -- things like autoimport and snippets
        'saadparwaiz1/cmp_luasnip', -- cmp specifically to help with LuaSnip
        'L3MON4D3/LuaSnip',         -- snippet engine
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require("luasnip")

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
                ['<C-p>'] = cmp.mapping.confirm({ select = true }),  -- here so I can overwrite this mapping on Windows Terminal
                -- use the following to map <S-CR> to <C-p> in winterm (this way you can use the shift+enter in all terminals)
                --{ "command": { "action": "sendInput", "input": "\u0010" }, "keys": "shift+enter" }


            }),
            sources = cmp.config.sources({
                { name = 'luasnip' },
                { name = 'nvim_lua' },
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'buffer',  keyword_length = 4 },
                { name = 'text',    keyword_length = 4 },
                { name = 'Text',    keyword_length = 4 },
            }),

            experimental = {
                ghost_text = true,
            },

            -- TODO look into "formatting"
        })

        luasnip.config.set_config({
            -- tell LuaSnip to stay around for the last snippet
            history = true,

            -- here to update as you type
            updateevents = "TextChanged",
            "TextChangedI",

            -- AutoSnippets
            enable_autosnippets = true,

        })

        -- set jumps in the snippet forward and backward
        vim.keymap.set({ "i", "s" }, "<C-k>", function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { silent = true })

        -- backward jump
        vim.keymap.set({ "i", "s" }, "<C-j>", function()
            if luasnip.jumpable() then
                luasnip.jump(-1)
            end
        end, { silent = true })

        -- go through "choice nodes"
        vim.keymap.set({ "i", "s" }, "<C-l>", function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end)

        -- for re-sourcing the LuaSnip file
        vim.keymap.set('n', '<leader><leader>s', "<cmd>source ~/.config/nvim/after/plugin/my_snips.lua<CR>")
    end,
}
