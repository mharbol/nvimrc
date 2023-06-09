
local status_ok, mark = pcall(require, 'harpoon.mark')
if not status_ok then
    return
end

local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

-- these are the hotkeys for the marked files
vim.keymap.set('n', '<C-h>', function() ui.nav_file(1) end)
vim.keymap.set('n', '<C-n>', function() ui.nav_file(2) end)
vim.keymap.set('n', '<C-z>', function() ui.nav_file(3) end)
vim.keymap.set('n', '<C-t>', function() ui.nav_file(4) end)
