return {
    'lewis6991/gitsigns.nvim',
    opts = {
        on_attach = function(bufnr)
            -- typically opts is just empty
            local opts = {}
            local gs = package.loaded.gitsigns
            opts.buffer = bufnr

            -- easily the most useful: see the diff on this hunk
            vim.keymap.set('n', '<leader>gd', gs.preview_hunk, opts)
            vim.keymap.set('n', '<leader>gid', gs.preview_hunk_inline, opts)

            -- seeing git blame
            vim.keymap.set('n', '<leader>gb', function() gs.blame_line({ full = true }) end, opts)  -- git blame on the hunk
            vim.keymap.set('n', '<leader>gB', function() gs.blame_line({ full = false }) end, opts) -- git blame on the line

            -- toggling show_deleted
            vim.keymap.set('n', '<leader>gD', function() gs.toggle_deleted() end, opts)
        end,

        -- how the gutter looks with git
        signs = {}, -- currently with the default
        show_deleted = false,
    }
}
