return {
    'mason-org/mason-lspconfig.nvim', -- lsp installer and configurator
    dependencies = {
        'mason-org/mason.nvim',       -- lsp installer
        'SmiteshP/nvim-navic',        -- ensure navic is up and running
        'neovim/nvim-lspconfig',      -- get default configs
    },
    config = function()
        local mason = require('mason')
        local telescope_builtin = require('telescope.builtin')

        mason.setup()

        require('mason-lspconfig').setup({
            ensure_installed = {
                'astro', -- install language server with 'npm install -g @astrojs/language-server'
                'cssls',
                'clangd',
                'cmake',
                "gopls", -- install gopls with go command "go install -v golang.org/x/tools/gopls@latest"
                'jdtls',
                'lua_ls',
                'pylsp',
                "rust_analyzer",
                'svelte',
                'zls',
            },
        })

        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = true,
            underline = false,
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local bufnr = ev.buf
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local opts = { noremap = true, silent = true } -- these are just here for standard remapping options

                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'gf', function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, opts)
                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('n', '<leader><leader>h',
                    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)

                vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
                vim.keymap.set('n', '<leader>b', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('n', '<leader>vl',
                    function() vim.diagnostic.config({ virtual_lines = (not vim.diagnostic.config().virtual_lines) }) end,
                    opts)
                vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

                -- Telescope LSP integration
                vim.keymap.set('n', 'gu', function() telescope_builtin.lsp_incoming_calls() end, opts)
                vim.keymap.set('n', 'go', function() telescope_builtin.lsp_outgoing_calls() end, opts)
                vim.keymap.set('n', 'gr', function() telescope_builtin.lsp_references() end, opts)

                -- format
                vim.keymap.set('n', '<leader><leader>f', function() vim.lsp.buf.format() end, opts)

                -- navic setup
                if nil ~= client and client.server_capabilities.documentSymbolProvider then
                    require('nvim-navic').attach(client, bufnr)
                end


                if nil ~= client and client:supports_method('textDocument/completion') then
                    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
                end
            end,
        })
    end,
}
