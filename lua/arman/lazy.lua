-- installing lazy if not installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
    'folke/lazy.nvim',
    -- lsp
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'simrat39/rust-tools.nvim',
    'folke/neodev.nvim',
    -- cmp
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    -- the godly plenary
    'nvim-lua/plenary.nvim',
    -- snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'simrat39/inlay-hints.nvim',
    'j-hui/fidget.nvim',
    { 'nvim-telescope/telescope.nvim', tag = '0.1.0' },
    -- treesitter
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-context',
    -- themes
    'ellisonleao/gruvbox.nvim',
    { 'Everblush/everblush.nvim', as = 'everblush' },
    { 'catppuccin/nvim', as = 'catppuccin' },
    { 'rose-pine/neovim', as = 'rose-pine' },
    'folke/tokyonight.nvim',
    'kdheepak/monochrome.nvim',
    'ray-x/aurora',
    'sainnhe/sonokai',
    'sainnhe/everforest',
    -- other
    'kyazdani42/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
    'ThePrimeagen/harpoon',
    'ziontee113/color-picker.nvim',
    'norcalli/nvim-colorizer.lua',
    'tanvirtin/vgit.nvim',
}

require('lazy').setup(plugins)
