
local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
    return
end

gitsigns.setup({
    on_attach = function(bufnr)

        -- typically opts in just empty
        local opts = {}
        local gs = package.loaded.gitsigns
        opts.buffer = bufnr

        -- easily the most useful: see the diff on this hunk
        vim.keymap.set('n', '<leader>gd', gs.preview_hunk, opts)
        vim.keymap.set('n', '<leader>gid', gs.preview_hunk_inline, opts)

        -- seeing git blame
        vim.keymap.set('n', '<leader>gb', function() gs.blame_line({full = true}) end, opts)  -- git blame on the hunk
        vim.keymap.set('n', '<leader>gB', function() gs.blame_line({full = false}) end, opts) -- git blame on the line

    end,

    -- how the gutter looks with git
    signs = {}, -- currently with the default
    show_deleted = false,
})
