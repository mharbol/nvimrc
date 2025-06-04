return {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    -- annoying annotations I want to get rid of
                    ignore = {
                        'E203',
                        'E302',
                        'W391', -- blank line at end of file
                    },
                    maxLineLength = 115
                }
            }
        }
    }
}
