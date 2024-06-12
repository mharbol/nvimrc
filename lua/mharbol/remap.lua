
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Remaps for moving blocks up and down in normal and visual modes
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- for veritcal movement
vim.keymap.set("n", "<C-d>", "<C-d>zz") --center the cursor as we half-page scroll down
vim.keymap.set("n", "<C-u>", "<C-u>zz") --center the cursor as we half-page scroll up

-- center as I move up and down when I want
vim.keymap.set("n", "<C-j>", "jzz")
vim.keymap.set("n", "<C-k>", "kzz")

-- I love being centered, so do that when I go
-- to the bottom
vim.keymap.set("n", "G", "Gzz")

-- move between splits with ctrl-[direction]
vim.keymap.set("n", "<S-Right>", "<C-w>l")
vim.keymap.set("n", "<S-Left>", "<C-w>h")
vim.keymap.set("n", "<S-Up>", "<C-w>k")
vim.keymap.set("n", "<S-Down>", "<C-w>j")
