return {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
        local tokyonight = require("tokyonight")
        tokyonight.setup({
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
            },
        })
        vim.cmd.colorscheme("tokyonight-moon")
    end,
}
