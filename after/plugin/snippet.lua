
local luasnip = require('luasnip')
-- local types = require('luasnip.util.types')

luasnip.config.set_config({
    -- tell LuaSnip to stay around for the last snippet
    history = true,

    -- here to update as you type 
    updateevents = "TextChanged", "TextChangedI",

    -- AutoSnippets
    enable_autosnippets = true,

})

-- set jumps in the snippet forward and backward
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

-- backward jump
vim.keymap.set({ "i", "s" }, "<C-j>", function ()
    if luasnip.jumpable() then
       luasnip.jump(-1)
    end
end, { silent = true })

-- go through "choice nodes"
vim.keymap.set({ "i", "s" }, "<C-l>", function ()
    if luasnip.choice_active() then
       luasnip.change_choice(1)
    end
end, { silent = true })

-- for re-sourcing the LuaSnip file
vim.keymap.set('n', '<leader><leader>s', "<cmd>source ~/.config/nvim/after/plugin/my_snips.lua<CR>")
