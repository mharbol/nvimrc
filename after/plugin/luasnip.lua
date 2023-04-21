
local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

ls.add_snippets('lua', {
    ls.snippet('lf', fmt('local function {}({})\n\t{}\nend', {
        i(1),
        i(2),
        i(3),
    })),
    ls.snippet('var', fmt('local {} = {}', {
        i(1, 'var'),
        i(2, 'value'),
    }))
})

ls.add_snippets('python', {

    -- "define"
    ls.snippet('df', fmt('def {}({}):\n\t{}', {
        i(1, 'func_name'),
        i(2),
        i(3, 'pass'),
    })),

    -- "define return"
    ls.snippet('dfr', fmt('def {}({}) -> {}:\n\t{}', {
        i(1, 'func_name'),
        i(2),
        i(3, 'ret_type'),
        i(4, 'pass'),
    })),
})

