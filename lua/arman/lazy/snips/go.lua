require('luasnip.session.snippet_collection').clear_snippets 'go'

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
            { c(0, { t 'return nil, err', i(0, '') }) }
        )
    ),
    s(
        'switch',
        fmt(
            [[
    switch {} {{
        {}
    }}
        ]],
            { i(1, ''), i(0, '') }
        )
    ),
    s(
        'select',
        fmt(
            [[
    select {} {{
        {}
    }}
        ]],
            { i(1, ''), i(0, '') }
        )
    ),
    s(
        'case',
        fmt(
            [[
    {} {}:
        {}
        ]],
            { c(1, { t 'case', t 'default' }), i(2, ''), i(0, '') }
        )
    ),
    s(
        'fori',
        fmt(
            [[
    for {}; {}; {} {{
        {}
    }}
        ]],
            { i(1, 'i := 0'), i(2, 'i < n'), i(3, 'i++'), i(0, '') }
        )
    ),
    s(
        'forw',
        fmt(
            [[
    for {} {{
        {}
    }}
        ]],
            { i(1, 'true'), i(0, '') }
        )
    ),
    s(
        'foreach',
        fmt(
            [[
    for {}, {} := range {} {{
        {}
    }}
        ]],
            { i(1, 'k'), i(2, 'v'), i(3, 'map'), i(0, '') }
        )
    ),
    s(
        'func',
        fmt(
            [[
    func {}({}) {}{{
        {}
    }}
        ]],
            { i(1, 'name'), i(2, ''), i(3, ''), i(0, '') }
        )
    ),
    s(
        'funct',
        fmt(
            [[
    func ({}){}({}) {}{{
        {}
    }}
        ]],
            { i(1, ''), i(2, 'name'), i(3, ''), i(4, ''), i(0, '') }
        )
    ),
    s(
        'type',
        fmt(
            [[
    type {} {} {{
        {}
    }}
        ]],
            { i(1, 'name'), c(2, { t 'struct', t 'interface' }), i(0, '') }
        )
    ),
})
