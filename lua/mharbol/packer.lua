
-- inspired by kickstart.nvim to install and make it all work on first load
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then

    -- we are currently bootstrapping so install packer
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }

    -- Only required if you have packer configured as `opt`
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- telescope add-on
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- treesitter
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- treesitter playground
    use ('nvim-treesitter/playground')

    -- HARPOON!!!!!
    use ('theprimeagen/harpoon')

    -- undo tree
    use 'mbbill/undotree'

    -- playing with status line
    use 'rebelot/heirline.nvim'

    -- very simple way to close brackets
    use 'm4xshen/autoclose.nvim'

    -- git integration and signs
    use 'lewis6991/gitsigns.nvim'

    -- shows progress for lsp indexing
    use 'j-hui/fidget.nvim'

    -- colorschemes seletion to choose from 
    use 'rebelot/kanagawa.nvim'
    use 'folke/tokyonight.nvim'
    use 'bluz71/vim-nightfly-colors'

    -- cmp plugins
    use 'hrsh7th/nvim-cmp' -- completion plugins
    use 'hrsh7th/cmp-buffer' -- buffer completion (words from the current buffer)
    use 'hrsh7th/cmp-path' -- path completion (files/filenames)
    use 'hrsh7th/cmp-nvim-lua' -- has special nvim knowledge
    use 'hrsh7th/cmp-nvim-lsp' -- things like autoimport and snippets
    use 'saadparwaiz1/cmp_luasnip' -- cmp specifically to help with LuaSnip

    -- snippets
    use 'L3MON4D3/LuaSnip' -- snippet engine
    -- use 'rafamadriz/friendly-snippets' -- lots of snippets

    -- LSP things
    use 'neovim/nvim-lspconfig' -- enables the LSP
    use 'williamboman/mason.nvim' -- lsp installer
    use 'williamboman/mason-lspconfig' -- lsp installer

    -- for nested context when coding
    use {
        'SmiteshP/nvim-navic',
        requires = 'neovim/nvim-lspconfig'
    }

    -- awesome way to set up comments
    use 'numToStr/Comment.nvim'

    -- nifty icons
    use 'nvim-tree/nvim-web-devicons' -- for icons in the filetree

    -- this waits and installs my plugins on the very first run
    if is_bootstrap then
        require('packer').sync()
        print '=================================='
        print '    Plugins are being installed'
        print '    Wait until Packer completes,'
        print '       then restart nvim'
        print '=================================='
        return
    end
end)
