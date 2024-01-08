return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd.colorscheme 'rose-pine'
        end,
    },
    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,
    },
    { 'Everblush/everblush.nvim', name = 'everblush', lazy = true },
    { 'catppuccin/nvim', name = 'catppuccin', lazy = true },
    { 'folke/tokyonight.nvim', lazy = true },
    { 'kdheepak/monochrome.nvim', lazy = true },
    {
        'ray-x/aurora',
        lazy = true,
        config = function()
            vim.g.aurora_italic = 1
            vim.g.aurora_transparent = 1
            vim.g.aurora_bold = 1
            vim.g.aurora_darker = 1
        end,
    },
    { 'sainnhe/sonokai', lazy = true },
    { 'sainnhe/everforest', lazy = true },
}
