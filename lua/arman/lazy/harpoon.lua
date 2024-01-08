return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        config = function()
            local harpoon = require 'harpoon'

            ---@diagnostic disable-next-line: missing-parameter
            harpoon:setup()
            --TODO: probably create my own harpoon list.

            vim.keymap.set('n', '<leader>ha', function()
                harpoon:list():append()
            end)
            vim.keymap.set('n', '<leader>he', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set('n', '<leader>hz', function()
                harpoon:list():select(1)
            end)
            vim.keymap.set('n', '<leader>hx', function()
                harpoon:list():select(2)
            end)
            vim.keymap.set('n', '<leader>hc', function()
                harpoon:list():select(3)
            end)
            vim.keymap.set('n', '<leader>hv', function()
                harpoon:list():select(4)
            end)
        end,
    },
}
