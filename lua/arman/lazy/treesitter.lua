return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = 'TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash',
                    'c',
                    'cpp',
                    'c_sharp',
                    'css',
                    'gdscript',
                    'git_config',
                    'git_rebase',
                    'gitattributes',
                    'gitcommit',
                    'gitignore',
                    'go',
                    'gomod',
                    'html',
                    'htmldjango',
                    'javascript',
                    'ocaml',
                    'odin',
                    'python',
                    'rust',
                    'toml',
                    'typescript',
                    'yaml',
                    'zig',
                },
                sync_install = false,
                modules = {},
                auto_install = true,
                ignore_install = {},
            }

            require('treesitter-context').setup {
                mode = 'cursor',
                enable = true,
                zindex = 20,
                max_lines = 0,
                trim_scope = 'outer',
                line_numbers = true,
                min_window_height = 0,
                multiline_threshold = 20,
            }
        end,
    },
    'nvim-treesitter/nvim-treesitter-context',
}
