return {
    'nvim-tree/nvim-web-devicons',
    config = function()
        local devicons = require('nvim-web-devicons')
        devicons.set_icon({
            v = {
                icon = "",
                color = "#5d87bf",
                cterm_color = "67",
                name = "Vlang",
            }
        })
    end
}
