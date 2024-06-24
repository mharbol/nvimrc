return {
    'rebelot/heirline.nvim',
    dependencies = {
        'SmiteshP/nvim-navic',
    },
    config = function()
        local heirline = require("heirline")
        local utils = require("heirline.utils")
        local conditions = require("heirline.conditions")

        -- this ties my current colorscheme to the heirline colors
        local function setup_colors()
            return {
                bright_bg = utils.get_highlight("Folded").bg,
                bright_fg = utils.get_highlight("Folded").fg,
                red = utils.get_highlight("DiagnosticError").fg,
                dark_red = utils.get_highlight("DiffDelete").bg,
                green = utils.get_highlight("String").fg,
                blue = utils.get_highlight("Function").fg,
                gray = utils.get_highlight("NonText").fg,
                orange = utils.get_highlight("Constant").fg,
                purple = utils.get_highlight("Statement").fg,
                cyan = utils.get_highlight("Special").fg,
                diag_warn = utils.get_highlight("DiagnosticWarn").fg,
                diag_error = utils.get_highlight("DiagnosticError").fg,
                diag_hint = utils.get_highlight("DiagnosticHint").fg,
                diag_info = utils.get_highlight("DiagnosticInfo").fg,
                git_del = utils.get_highlight("diffDelete").fg,
                git_add = utils.get_highlight("diffAdd").fg,
                git_change = utils.get_highlight("diffChange").fg,
            }
        end

        require('heirline').load_colors(setup_colors)

        vim.api.nvim_create_augroup("Heirline", { clear = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                local colors = setup_colors()
                utils.on_colorscheme(colors)
            end,
            group = "Heirline",
        })
        -- end colorscheme binding

        -- Here we define all the different informations we want in the statusline
        -- tells me which LSPs are active
        local lsp_active = {
            condition = conditions.lsp_attached,
            update = { 'LspAttach', 'LspDetach' },
            provider = function()
                local names = {}
                for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    table.insert(names, server.name)
                end
                return " [" .. table.concat(names, " ") .. "]"
            end,
            hl = { fg = "green", bold = true, bg = nil }
        }

        -- updates for git info
        local git_info = {
            condition = conditions.is_git_repo,
            init = function(self)
                self.status_dict = vim.b.gitsigns_status_dict
                self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
                    self.status_dict.changed ~= 0
            end,
            hl = { fg = 'orange' },

            -- git branch name
            {
                provider = function(self)
                    return "  " .. self.status_dict.head .. " "
                end,
                hl = { bold = true }
            },
        }

        local diagnosic_info = {
            -- condition = conditions.has_diagnostics,
            condition = conditions.lsp_attached,
            static = {
                error_icon = "  ",
                warn_icon = "  ",
                info_icon = "  ",
                hint_icon = " 󱠃 ",
            },
            init = function(self)
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,
            update = { "DiagnosticChanged", "BufEnter" },
            {
                provider = function(self)
                    return self.error_icon .. self.errors
                end,
                hl = { fg = "diag_error" },
            },
            {
                provider = function(self)
                    return self.warn_icon .. self.warnings
                end,
                hl = { fg = "diag_warn" },
            },
            {
                provider = function(self)
                    return self.info_icon .. self.info
                end,
                hl = { fg = "diag_info" },
            },
            {
                provider = function(self)
                    return self.hint_icon .. self.hints
                end,
                hl = { fg = "diag_hint" },
            },
            {
                provider = " ",
            }
        }

        local LINE_COUNT_TEXT_STRING = "%7(%l/%3L%):%2c %P "
        local scroll_bar_info = {
            -- this gives me my position overall
            {
                provider = LINE_COUNT_TEXT_STRING
            },

            {
                static = {
                    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
                },
                provider = function(self)
                    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                    return string.rep(self.sbar[i], 2)
                end,
                hl = { fg = "blue", bg = "bright_bg" },
            }
        }

        local file_info = {

            -- init with getting the file name
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
            end,

            {
                provider = function(self)
                    -- first, trim the pattern relative to the current directory. For other
                    -- options, see :h filename-modifers
                    local filename = vim.fn.fnamemodify(self.filename, ":.")
                    if filename == "" then return "[No Name]" end
                    -- now, if the filename would occupy more than 1/4th of the available
                    -- space, we trim the file path to its initials
                    -- See Flexible Components section below for dynamic truncation
                    if not conditions.width_percent_below(#filename, 0.25) then
                        filename = vim.fn.pathshorten(filename)
                    end
                    return filename
                end,
                hl = { fg = utils.get_highlight("Directory").fg }
            },

            -- this guy tells me if the file has been modified
            {
                condition = function()
                    return vim.bo.modified
                end,
                provider = " [+]",
                hl = { fg = "green", bold = true },
            }
        }

        local navic_info = {
            condition = function() return require('nvim-navic').is_available() end,
            provider = function()
                return require('nvim-navic').get_location({ highlight = true })
            end,
            update = 'CursorMoved',
        }

        -- spaces the Navic bar where I want
        local wibar_spacer = {
            condition = function() return true end,
            provider = "      ",
        }

        -- spaces components as needed absolutely
        local align = { provider = "%=" }
        local space = { provider = " " }

        -- aaaaaand... finally get to set them
        heirline.setup({
            statusline = {
                git_info,
                space,
                file_info,
                align,
                diagnosic_info,
                space,
                lsp_active,
                space,
                scroll_bar_info,
                space,
                hl = { bg = "#16161d" }
            },
            winbar = { wibar_spacer, navic_info },
        })
    end
}
