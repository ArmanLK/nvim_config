return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup {
                dark_variant = 'main',
            }
        end,
    },
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        config = function()
            require('gruvbox').setup {
                contrast = 'hard',
                transparent_mode = true,
            }

            vim.cmd.colorscheme 'gruvbox'
        end,
    },
    {
        'Everblush/everblush.nvim',
        name = 'everblush',
        config = function()
            require('everblush').setup {
                transparent_background = true,
            }
        end,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup {
                transparent_background = true,
                flavour = 'mocha',
            }
        end,
    },
    {
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').setup {
                style = 'nigth',
                transparent = true,
                terminal_colors = true,
            }
        end,
    },
    { 'kdheepak/monochrome.nvim' },
    {
        'ray-x/aurora',
        config = function()
            vim.g.aurora_italic = 1
            vim.g.aurora_transparent = 1
            vim.g.aurora_bold = 1
            vim.g.aurora_darker = 1
        end,
    },
    {
        'sainnhe/sonokai',
        config = function()
            vim.g.sonokai_style = 'atlantis' -- 'defualt', 'atlantis', 'shusia', 'maia', 'espresso'
            vim.g.sonokai_transparent_background = 1
        end,
    },
    {
        'sainnhe/everforest',
        config = function()
            vim.g.everforest_background = 'hard' -- 'hard','medium', 'soft'
            vim.g.everforest_transparent_background = 1
        end,
    },
}
