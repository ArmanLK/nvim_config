return {
    'folke/lazy.nvim',
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
    'ziontee113/color-picker.nvim',
    'norcalli/nvim-colorizer.lua',

    config = function()
        require('colorizer').setup()
        require('color-picker').setup()
        require('lualine').setup {}
    end,
}
