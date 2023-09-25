local ls = require 'luasnip'
require 'arman.lsnip.lua'
require 'arman.lsnip.rust'
require 'arman.lsnip.python'
require 'arman.lsnip.node'
require 'arman.lsnip.zig'

local set_key = vim.keymap.set

ls.config.set_config {
    -- rememner the last snippet (just in case if some thing is wrong)
    -- can jumo back to it even if you are out of selection (sounds cool)
    history = true,
    -- dynamic snippet (updates texts as I type)
    updateevents = 'TextChanged,TextChangedI',
    -- auto snippets
    enable_autosnippets = true,
}

-- some keys
-- forward jump
set_key({ 'i', 's' }, '<c-k>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })
-- jump backward
set_key({ 'i', 's' }, '<c-j>', function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
-- selecting within a list of options
set_key({ 'i', 's' }, '<c-l>', function()
    if ls.choice_active() then
        ls.change_choice()
    end
end)
