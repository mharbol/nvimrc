local ls = require 'luasnip'
local s = ls.s                                -- shorthand for snippet node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt -- for combining formatted strings
local rep = require('luasnip.extras').rep     -- repeat what is in position

-- table that hold our snippets
ls.add_snippets("all", {

})

ls.add_snippets("lua", {
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n\t$0\nend"),                                                    -- local function
    ls.parser.parse_snippet("parse", "ls.parser.parse_snippet(\"${1:name}\", \"${2:snippet_code}\"), -- ${3:description}"), -- make a new snippet
    ls.parser.parse_snippet("var", "local ${1:var_name} = ${2:value}"),                                                     -- local variable
    s('req', fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),                                                 -- name the require the same
})

ls.add_snippets("python", {
    ls.parser.parse_snippet("df", "def ${1:name}($2):\n\t${0:pass}"), -- define a function
})
