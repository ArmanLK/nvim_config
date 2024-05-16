require('luasnip.session.snippet_collection').clear_snippets 'javascript'
require('luasnip.session.snippet_collection').clear_snippets 'typescript'
require('luasnip.session.snippet_collection').clear_snippets 'javascriptreact'
require('luasnip.session.snippet_collection').clear_snippets 'typescriptreact'

local ls = require 'luasnip'
local s, t, c = ls.s, ls.text_node, ls.choice_node
local d, i, f = ls.dynamic_node, ls.insert_node, ls.function_node
local sn = ls.sn
-- local extras = require("luasnip.extras")
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local add = ls.add_snippets

local snips = {
    s(
        'exfun',
        fmt(
            [[
    export{}function {}() {{
        {}
    }}
    ]],
            {
                c(1, { t ' ', t ' default ', t ' async ' }),
                i(2, 'name'),
                i(0),
            }
        )
    ),
}
add('javascript', snips)
add('typescript', snips)
add('typescriptreact', snips)
add('javascriptreact', snips)
