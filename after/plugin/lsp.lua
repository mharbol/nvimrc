
-- for managing lsp server
local status_ok, mason = pcall(require, 'mason')
if not status_ok then
    return
end

local tele_status_ok, telescope_builtin = pcall(require, 'telescope.builtin')
if not tele_status_ok then
    return
end

local util = require("lspconfig/util")

mason.setup()

require('mason-lspconfig').setup({
    ensure_installed = {
        'gopls', -- install gopls with go command "go install -v golang.org/x/tools/gopls@latest"
        'pylsp',
        'clangd',
        'astro', -- install language server with 'npm install -g @astrojs/language-server'
        'lua_ls',
        'jdtls',
        'gradle_ls',
        'rust_analyzer',
        'hls',
    },
})
local lsp = require('lspconfig')

-- for "capabilities" I guess
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- mappings set for the lsp attached
local on_attach = function(client, bufnr)
    local opts = {noremap = true, silent = true} -- these are just here for standard remapping options

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set('n', 'K',  function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', '<leader>b', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)

    -- Telescop LSP integration
    vim.keymap.set('n', 'gu', function() telescope_builtin.lsp_incoming_calls() end, opts)
    vim.keymap.set('n', 'go', function() telescope_builtin.lsp_outgoing_calls() end, opts)
    vim.keymap.set('n', 'gr', function() telescope_builtin.lsp_references() end, opts)

    -- format
    vim.keymap.set('n', '<leader><leader>f', function() vim.lsp.buf.format() end, opts)

    -- navic setup
    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end
end

-- these are here for individual setup
-- Suggested lua setup
lsp.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

-- setuo for Go
lsp.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- cmd = {"gopls", "serve"},
    -- filetypes = {"go", "gomod"},
    -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    -- settings = {
    --     gopls = {
    --         gofumpt = true,
    --         analyses = {
    --             unusedparams = true,
    --         },
    --         staticcheck = true,
    --     },
    -- },
})

-- python LSPing
lsp.pylsp.setup{
    capabilities = capabilities,
    on_attach = on_attach,
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
lsp.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {"clangd"},
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto"},
    root_dir = util.root_pattern(
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
    ),
    single_file_support = true,
})

lsp.astro.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

lsp.tsserver.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    init_options = {
        hostInfo = "neovim"
    },
    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    single_file_support = true,
}

lsp.jdtls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp.gradle_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp.dartls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp.hls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- cmd = {"haskell-language-server-8.10.7", "--lsp"}
})
