
-- local status_ok, kanagawa = pcall(require, "kanagawa")
-- if not status_ok then
--     return
-- end
--
-- local kanagawa_default_colors = require("kanagawa.colors").setup()
local tokyonight = require("tokyonight")
tokyonight.setup({
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
    },
})

local kanagawa = require('kanagawa')
kanagawa.setup({
    theme = "wave",
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
    functionStyle = {},
    colors = {
        theme = {
            -- change specific usages for a certain theme, or for all of them
            all = {
                ui = {
                    bg_gutter = "none"
                }
            }
        }
    }
})

function ColorMyPencils(color)
    color = color or "kanagawa"
    vim.cmd.colorscheme(color)

    -- Here if I want to haev a kickass background for my terminal
	-- vim.api.nvim_set_hl(0, "Normal", {bg = "None"})
	-- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end

ColorMyPencils("tokyonight-moon")
-- ColorMyPencils("kanagawa")
