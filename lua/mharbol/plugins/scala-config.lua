-- Follow setup here:
-- https://github.com/scalameta/nvim-metals
-- stop server with `scala-cli --power bloop exit`
return {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
        local metals_config = require("metals").bare_config()
        metals_config.on_attach = function(client, bufnr)
            -- your on_attach function
            local opts = { noremap = true, silent = true } -- these are just here for standard remapping options

            vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set('n', 'gf', function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, opts)
            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set('n', '<leader><leader>h',
                function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)

            -- TODO clean up when release goes to >=0.11.x
            if vim.version().minor < 11 then
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
            else
                vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
            end
            vim.keymap.set('n', '<leader>b', function() vim.lsp.buf.references() end, opts)
            vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

            -- Telescop LSP integration
            vim.keymap.set('n', 'gu', function() telescope_builtin.lsp_incoming_calls() end, opts)
            vim.keymap.set('n', 'go', function() telescope_builtin.lsp_outgoing_calls() end, opts)
            vim.keymap.set('n', 'gr', function() telescope_builtin.lsp_references() end, opts)

            -- format
            vim.keymap.set('n', '<leader><leader>f', function() vim.lsp.buf.format() end, opts)
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
