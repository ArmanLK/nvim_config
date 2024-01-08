return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local builtin = require 'telescope.builtin'

            vim.keymap.set('n', '<leader>fa', builtin.fd)
            vim.keymap.set('n', '<leader>fb', builtin.buffers)
            vim.keymap.set('n', '<leader>fg', builtin.live_grep)
            -- vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
            vim.keymap.set('n', '<leader>fr', builtin.registers)
            -- vim.keymap.set('n', '<leader>fi', builtin.builtin)

            -- the cool ones
            vim.keymap.set('n', '<leader>fw', function()
                builtin.grep_string { search = vim.fn.expand '<cword>' }
            end)
            vim.keymap.set('n', '<leader>fW', function()
                builtin.grep_string { search = vim.fn.expand '<cWORD>' }
            end)
            vim.keymap.set('n', '<leader>fs', function()
                builtin.grep_string { search = vim.fn.input 'Grep > ' }
            end)
        end,
    },
}
