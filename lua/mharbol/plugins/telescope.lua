local git_repo_path = vim.loop.cwd() .. "/.git"

local function is_git_repo()
    local ok, _ = vim.loop.fs_stat(git_repo_path)
    return ok
end

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
        local builtin = require('telescope.builtin')
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        --  Find "Project Files" defautlts to git files if this is a git repo
        vim.keymap.set('n', '<leader>pf',
            function()
                if is_git_repo then
                    builtin.git_files()
                else
                    builtin.find_files()
                end
            end,
            { desc = "[P]roject [F]iles" })

        -- find "git files"
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "[G]it [F]iles" })

        -- find in all files
        vim.keymap.set('n', '<leader>pa', builtin.find_files, { desc = "[P]roject [A]ll" })

        -- "Project Search"
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "[P]roject [S]earch" }) -- `cargo install ripgrep` to get this one working

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                    },
                },
            },
        })
    end,
}
