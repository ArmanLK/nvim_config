require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'gdscript',
        'git-config',
        'git-rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
    },
}
require('treesitter-context').setup {}
