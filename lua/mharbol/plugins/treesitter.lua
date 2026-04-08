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
    init = function()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
