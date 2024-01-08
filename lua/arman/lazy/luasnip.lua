return {
    {
        'L3MON4D3/LuaSnip',
        tag = 'v2.2.0',
        config = function()
            local ls = require 'luasnip'
            require 'arman.lazy.snips.go'
            require 'arman.lazy.snips.lua'
            require 'arman.lazy.snips.zig'
            require 'arman.lazy.snips.node'
            require 'arman.lazy.snips.rust'
            require 'arman.lazy.snips.python'

            ls.config.set_config {
                -- rememner the last snippet (just in case if some thing is wrong)
                -- can jumo back to it even if you are out of selection (sounds cool)
                history = true,
                -- dynamic snippet (updates texts as I type)
                updateevents = 'TextChanged,TextChangedI',
                -- auto snippets
                enable_autosnippets = true,
            }

            -- forward jump
            vim.keymap.set({ 'i', 's' }, '<c-k>', function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })
            -- jump backward
            vim.keymap.set({ 'i', 's' }, '<c-j>', function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
            -- selecting within a list of options
            vim.keymap.set({ 'i', 's' }, '<c-l>', function()
                if ls.choice_active() then
                    ls.change_choice()
                end
            end)
        end,
    },
}
