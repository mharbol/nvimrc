
-- is_bootstrap bit
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

    -- Packer can manage itself
    -- 'wbthomason/packer.nvim',

    -- telescope add-on
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        -- commit = '150be01d' -- here because treesitter works here in case of bad things
    },
    -- treesitter playground
    'nvim-treesitter/playground',

    -- HARPOON!!!!!
    'theprimeagen/harpoon',

    -- undo tree
    'mbbill/undotree',

    -- playing with status line
    'rebelot/heirline.nvim',

    -- very simple way to close brackets
    'm4xshen/autoclose.nvim',

    -- git integration and signs
    'lewis6991/gitsigns.nvim',

    -- shows progress for lsp indexing
    'j-hui/fidget.nvim',

    -- colorschemes seletion to choose from 
    'rebelot/kanagawa.nvim',
    'folke/tokyonight.nvim',
    'bluz71/vim-nightfly-colors',

    -- cmp plugins
    'hrsh7th/nvim-cmp', -- completion plugins
    'hrsh7th/cmp-buffer', -- buffer completion (words from the current buffer)
    'hrsh7th/cmp-path', -- path completion (files/filenames)
    'hrsh7th/cmp-nvim-lua', -- has special nvim knowledge
    'hrsh7th/cmp-nvim-lsp', -- things like autoimport and snippets
    'saadparwaiz1/cmp_luasnip', -- cmp specifically to help with LuaSnip

    -- snippets
    'L3MON4D3/LuaSnip', -- snippet engine
    -- use 'rafamadriz/friendly-snippets' -- lots of snippets

    -- LSP things
    'neovim/nvim-lspconfig', -- enables the LSP
    'williamboman/mason.nvim', -- lsp installer
    'williamboman/mason-lspconfig', -- lsp installer

    -- for nested context when coding
    {
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig'
    },

    -- awesome way to set up comments
    'numToStr/Comment.nvim',

    -- nifty icons
    'nvim-tree/nvim-web-devicons', -- for icons in the filetree

    -- filetree navigation as a nvim buffer
    'stevearc/oil.nvim',
}

local opts = {}
require("lazy").setup(plugins, opts)
