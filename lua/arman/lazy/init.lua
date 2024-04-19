return {
    'folke/lazy.nvim',
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {}
        end
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },

    {
        'ziontee113/color-picker.nvim',
        config = function()
            require('color-picker').setup()
        end,
    }
}
