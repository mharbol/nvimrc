return {
    'nvim-tree/nvim-web-devicons',
    config = function()
        local devicons = require('nvim-web-devicons')
        devicons.set_icon({
            ["toml"] = {
                icon = "T",
                color = "#ffffff",
                cterm_color = "231",
                name = "Toml",
            },
        })
    end
}
