require('luasnip.session.snippet_collection').clear_snippets 'python'

local ls = require 'luasnip'
local s, t, c = ls.s, ls.text_node, ls.choice_node
local d, i, f = ls.dynamic_node, ls.insert_node, ls.function_node
local sn = ls.sn
-- local extras = require("luasnip.extras")
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local add = ls.add_snippets

add('python', {
    s(
        'ifname',
        fmt(
            [[
        if __name__ == '__main__':
            {}
        ]],
            {
                i(1, 'pass'),
            }
        )
    ),
    s(
        'def',
        fmt(
            [[
    def {}({}):
        {}
    ]],
            {
                i(1, 'function_name'),
                i(2, '*args, **kwargs'),
                i(0, 'pass'),
            }
        )
    ),
    s(
        'while',
        fmt(
            [[
    while {}:
        {}
    ]],
            {
                i(1, 'conds'),
                i(0, 'pass'),
            }
        )
    ),
    s(
        'for',
        fmt(
            [[
    for {} in {}:
        {}
    ]],
            {
                i(1, 'item'),
                i(2, 'items'),
                i(0, 'pass'),
            }
        )
    ),
    s(
        'if',
        fmt(
            [[
    if {}:
        {}
    ]],
            {
                i(1, 'conds'),
                i(0, 'pass'),
            }
        )
    ),
    s(
        'ifelse',
        fmt(
            [[
    if {}:
        {}
    else:
        {}
    ]],
            {
                i(1, 'conds'),
                i(2, 'pass'),
                i(0, 'pass'),
            }
        )
    ),
    s(
        'try',
        fmt(
            [[
    try:
        {}
    except {}:
        {}
    ]],
            {
                i(1, 'pass'),
                i(2, 'Exception'),
                i(0, 'pass'),
            }
        )
    ),
    s(
        'deft',
        fmt(
            [[
    def {}({}) -> {}:
        {}
    ]],
            {
                i(1, 'function_name'),
                i(2, '*args, **kwargs'),
                i(3, 'type'),
                i(0, 'pass'),
            }
        )
    ),
    --TODO: this needs some optimization
    s(
        'doc',
        fmt(
            [[
    """summery: {}
    Args: {}
    Returns:{}
    """
    ]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),
    s(
        'from',
        fmt('from {} import {}', {
            i(1, 'package'),
            i(0, 'module'),
        })
    ),
    s('import', fmt('import {}', { i(0, 'module') })),
})
