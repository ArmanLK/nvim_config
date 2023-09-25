local vgit = vim.F.npcall(require, 'vgit')
if not vgit then
    return
end

-- mostly copied
vgit.setup {
    keymaps = {
        ['n <C-k>'] = function()
            vgit.hunk_up()
        end,
        ['n <C-j>'] = function()
            vgit.hunk_down()
        end,
        ['n <leader>gs'] = function()
            vgit.buffer_hunk_stage()
        end,
        ['n <leader>gr'] = function()
            vgit.buffer_hunk_reset()
        end,
        ['n <leader>gp'] = function()
            vgit.buffer_hunk_preview()
        end,
        ['n <leader>gb'] = function()
            vgit.buffer_blame_preview()
        end,
        ['n <leader>gd'] = function()
            vgit.buffer_diff_preview()
        end,
        ['n <leader>gh'] = function()
            vgit.buffer_history_preview()
        end,
        ['n <leader>gu'] = function()
            vgit.buffer_reset()
        end,
        ['n <leader>gg'] = function()
            vgit.buffer_gutter_blame_preview()
        end,
        ['n <leader>glu'] = function()
            vgit.buffer_hunks_preview()
        end,
        ['n <leader>gls'] = function()
            vgit.project_hunks_staged_preview()
        end,
        ['n <leader>gf'] = function()
            vgit.project_diff_preview()
        end,
        ['n <leader>gq'] = function()
            vgit.project_hunks_qf()
        end,
        ['n <leader>gx'] = function()
            vgit.toggle_diff_preference()
        end,
    },
    settings = {
        git = {
            cmd = 'git', -- optional setting, not really required
            fallback_cwd = vim.fn.expand '$HOME',
            fallback_args = {
                '--git-dir',
                vim.fn.expand '$HOME/dots/yadm-repo',
                '--work-tree',
                vim.fn.expand '$HOME',
            },
        },
        hls = {
            GitBackground = 'Normal',
            GitHeader = 'NormalFloat',
            GitFooter = 'NormalFloat',
            GitBorder = 'LineNr',
            GitLineNr = 'LineNr',
            GitComment = 'Comment',
            GitSignsAdd = {
                gui = nil,
                fg = '#d7ffaf',
                bg = nil,
                sp = nil,
                override = false,
            },
            GitSignsChange = {
                gui = nil,
                fg = '#7AA6DA',
                bg = nil,
                sp = nil,
                override = false,
            },
            GitSignsDelete = {
                gui = nil,
                fg = '#e95678',
                bg = nil,
                sp = nil,
                override = false,
            },
            GitSignsAddLn = 'DiffAdd',
            GitSignsDeleteLn = 'DiffDelete',
            GitWordAdd = {
                gui = nil,
                fg = nil,
                bg = '#5d7a22',
                sp = nil,
                override = false,
            },
            GitWordDelete = {
                gui = nil,
                fg = nil,
                bg = '#960f3d',
                sp = nil,
                override = false,
            },
        },
        live_gutter = {
            enabled = true,
            edge_navigation = true, -- This allows users to navigate within a hunk
        },
        authorship_code_lens = {
            enabled = true,
        },
        scene = {
            diff_preference = 'unified', -- unified or split
            keymaps = {
                quit = 'q',
            },
        },
        diff_preview = {
            keymaps = {
                buffer_stage = 'S',
                buffer_unstage = 'U',
                buffer_hunk_stage = 's',
                buffer_hunk_unstage = 'u',
                toggle_view = 't',
            },
        },
        project_diff_preview = {
            keymaps = {
                buffer_stage = 's',
                buffer_unstage = 'u',
                buffer_hunk_stage = 'gs',
                buffer_hunk_unstage = 'gu',
                buffer_reset = 'r',
                stage_all = 'S',
                unstage_all = 'U',
                reset_all = 'R',
            },
        },
        project_commit_preview = {
            keymaps = {
                save = 'S',
            },
        },
    },
}
