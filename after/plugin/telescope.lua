
local status_ok, builtin = pcall(require, 'telescope.builtin')
if not status_ok then
    return
end

--  Find "Project Files"
vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "[P]roject [F]iles"})

-- find "git files"
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "[G]it [F]iles"})

-- "Project Search"
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {desc = "[P]roject [S]earch"}) -- `cargo install ripgrep` to get this one working
