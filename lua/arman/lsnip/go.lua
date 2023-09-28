local ls = require 'luasnip'
local s, t, c = ls.s, ls.text_node, ls.choice_node
local i = ls.insert_node
-- local extras = require("luasnip.extras")
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local add = ls.add_snippets

add('go', {
    s(
        'if',
        fmt(
            [[
    if {} {{
        {}
    }}
        ]],
            {
                i(1, 'true'),
                i(0, ''),
            }
        )
    ),
    s(
        'iferr',
        fmt(
            [[
    if err != nil {{
        {}
    }}
        ]],
            { c { t 'return err', i(0, '') } }
        )
    ),
    s(
        'fori',
        fmt(
            [[
    for {};{};{} {{
        {}
    }}
        ]],
            { i(1, 'i := 0'), i(2, 'i < n'), i(3, 'i++'), i(0, '') }
        )
    ),
    s(
        'forw',
        fmt [[
    for {} {{
        {}
    }}
        ]],
        { i(1, 'true'), i(0, '') }
    ),
    s(
        'foreach',
        fmt(
            [[
    for {}, {} := range {} {{
        {}
    }}
        ]],
            { i(1, 'k'), i(2, 'v'), i(0, 'map') }
        )
    ),
})
