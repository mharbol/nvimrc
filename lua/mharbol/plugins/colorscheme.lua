return {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
        local kanagawa = require('kanagawa')
        local colors = require("kanagawa.colors").setup({theme = "wave"})
        local palette_colors = colors.palette
        kanagawa.setup({
            commentStyle = {
                italic = false,
            },
            keywordStyle = {
                italic = false,
            },
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                        vcs = {
                            changed = palette_colors.waveBlue2,
                        },
                    },
                },
            },
        })
        vim.cmd.colorscheme('kanagawa-wave')
    end,
}
