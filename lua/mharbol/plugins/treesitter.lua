return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local treesitter = require 'nvim-treesitter'
        treesitter.setup()
        treesitter.install({
            'astro',
            'bash',
            'c',
            'cpp',
            'dart',
            'go',
            'html',
            'java',
            'javascript',
            -- 'latex',
            'lua',
            'markdown',
            'python',
            'rust',
            'sql',
            'toml',
            'typescript',
            'vue',
            'yaml',
            'zig',
        })
    end,
}
