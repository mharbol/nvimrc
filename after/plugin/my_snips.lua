local ls = require 'luasnip'
local s = ls.s -- shorthand for snippet node
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt -- for combining formatted strings
local rep = require('luasnip.extras').rep     -- repeat what is in position

-- table that holds common snippets for all languages
ls.add_snippets("all", {
    s("curtime", f(function() return os.date("%D - %H:%M") end)), -- an example function node
})

ls.add_snippets("lua", {
    ls.parser.parse_snippet("lf", "local ${1:func_name} = function($2)\n\t$0\nend"),                                        -- local function
    ls.parser.parse_snippet("parse", "ls.parser.parse_snippet(\"${1:name}\", \"${2:snippet_code}\"), -- ${3:description}"), -- make a new VSc*** style snippet
    ls.parser.parse_snippet("var", "local ${1:var_name} = ${2:value}"),                                                     -- local variable
    s('req', fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),                                                 -- name the require the same
})

ls.add_snippets("python", {
    ls.parser.parse_snippet("dfr", "def ${1:func_name}($2) -> ${3:ret_type}:\n\t${0:pass}"),                       -- function with return type
    ls.parser.parse_snippet("df", "def ${1:func_name}($2):\n\t${0:pass}"),                                         -- define a function
    ls.parser.parse_snippet("cls", "class ${1:class_name}:\n\t${0:pass}"),                                         -- define a class
    ls.parser.parse_snippet("cdr", "def ${1:method_name}(self$2) -> ${3:return_type}:\n\t${0:pass}"),              -- "class define return"
    ls.parser.parse_snippet("cd", "def ${1:method_name}(self$2):\n\t${0:pass}"),                                   -- "class define"
    ls.parser.parse_snippet("init", "def __init__(self$1) -> None:\n\t${0:pass}"),                                 -- define the init for a class
    ls.parser.parse_snippet("lt", "dev __lt__(self, other) -> bool:\n\t${0:pass}"),                                -- define less than
    ls.parser.parse_snippet("gt", "dev __gt__(self, other) -> bool:\n\t${0:pass}"),                                -- define greater than
    ls.parser.parse_snippet("eq", "dev __eq__(self, other) -> bool:\n\t${0:pass}"),                                -- define equal to
    ls.parser.parse_snippet("neq", "dev __neq__(self, other) -> bool:\n\t${0:return not self == other}"),          -- define not equal to
    ls.parser.parse_snippet("main", "def main() -> None:\n\t${0:pass}\n\n\nif __name__ == '__main__':\n\tmain()"), -- make a main function
})

ls.add_snippets("java", {
    ls.parser.parse_snippet("main", "public static void main(String[] args) {\n\t$0\n}"), -- main method
    ls.parser.parse_snippet("str", "String ${1:str} = \"$0\";"),                          -- make a string
    ls.parser.parse_snippet("alist", "List<${1:type}> ${2:name} = new ArrayList<>();"),   -- make an ArrayList
})

ls.add_snippets("go", {
    ls.parser.parse_snippet("rloop", "for _, ${1:item} := range ${2:iterable} {\n\t$0\n}"),           -- "range loop"
    ls.parser.parse_snippet("riloop", "for ${1:index}, ${2:item} := range ${3:iterable} {\n\t$0\n}"), -- "range index loop"
    ls.parser.parse_snippet("tstr", "type ${1:name} struct {\n\t$0\n}"),                              -- make a new struct type
})

ls.add_snippets("astro", {
    ls.parser.parse_snippet("slot", "<slot />"), -- add a slot
})
