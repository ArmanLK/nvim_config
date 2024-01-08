local ls = require 'luasnip'
local s, t, c = ls.s, ls.text_node, ls.choice_node
local d, i, f = ls.dynamic_node, ls.insert_node, ls.function_node
-- local sn = ls.sn
-- local extras = require("luasnip.extras")
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local add = ls.add_snippets

add('rust', {
    s(
        'modtest',
        fmt(
            [[
    #[cfg(test)]
    mod test {{
    {}
    }}
    ]],
            {
                c(1, { t '    use super::*;', t '' }),
            }
        )
    ),
    s(
        'test',
        fmt(
            [[
    #[test]
    fn {}() {}{{
        {}
    }}
    ]],
            {
                i(1, 'test_name'),
                c(2, { t '', t '-> Result<()>', t '-> anyhow::Result<()> ' }),
                i(0),
            }
        )
    ),
    s(
        'main',
        fmt(
            [[
    fn main() {}{{
        {}
    }}
    ]],
            {
                c(1, { t '', t '-> Result<()>', t '-> anyhow::Result<()> ' }),
                i(0),
            }
        )
    ),
    s(
        'tmain',
        fmt(
            [[
    #[tokio::main]
    async fn main() {}{{
        {}
    }}
    ]],
            {
                c(1, { t '', t '-> Result<()> ', t '-> tokio::Result<()> ' }),
                i(0),
            }
        )
    ),
    s(
        'assert',
        fmt(
            [[
    {}({}, {});
    ]],
            {
                c(1, { t 'assert_eq!', t 'assert_ne!' }),
                i(2, 'true'),
                i(0, 'true'),
            }
        )
    ),
})
