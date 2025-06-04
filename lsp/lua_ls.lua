return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".git",
        ".luacheckrc",
        ".luarc.json",
        ".stylua.toml",
        "selene.toml",
        "selene.yml",
        "stylus.toml",
    },
    single_file_support = true,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
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
}
