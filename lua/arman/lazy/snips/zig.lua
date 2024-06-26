require('luasnip.session.snippet_collection').clear_snippets 'zig'

local ls = require 'luasnip'
local s, t, c = ls.s, ls.text_node, ls.choice_node
local d, i, f = ls.dynamic_node, ls.insert_node, ls.function_node
-- local sn = ls.sn
-- local extras = require("luasnip.extras")
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local add = ls.add_snippets

add('zig', {
    s(
        'import',
        fmt([[const {} = @import("{}");]], {
            t 'std',
            i(0),
        })
    ),
})
