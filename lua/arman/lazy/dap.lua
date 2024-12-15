return {
    'rcarriga/nvim-dap-ui',

    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
    },

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {
            desc = 'toggle [d]ebugger [b]reakpoint',
        })
        vim.keymap.set('n', '<leader>dl', '<cmd>DapNew<cr>', {
            desc = '[d]ebugger [l]aunch/attach',
        })
        vim.keymap.set('n', '<leader>dr', dap.restart, {
            desc = '[d]ebugger [r]estart',
        })
        vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, {
            desc = '[d]ebugger run to [c]ursor',
        })
        vim.keymap.set('n', '<leader>dn', dap.continue, {
            desc = '[d]ebugger co[n]tinue',
        })
        vim.keymap.set('n', '<leader>di', dap.step_into, {
            desc = '[d]ebugger step [i]nto',
        })
        vim.keymap.set('n', '<leader>do', dap.step_over, {
            desc = '[d]ebugger step [o]ver',
        })
        vim.keymap.set('n', '<leader>du', dap.step_out, {
            desc = '[d]ebugger step o[u]t',
        })
        vim.keymap.set('n', '<leader>dk', dap.step_back, {
            desc = '[d]ebugger step bac[k]',
        })

        vim.keymap.set('n', '<leader>?', function()
            ---@diagnostic disable-next-line: param-type-mismatch, missing-fields
            dapui.eval(nil, { enter = true })
        end)

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        --dap.adapters.lldb = {
        --    type = 'executable',
        --    command = '/bin/lldb-dap',
        --    name = 'lldb',
        --}

        dap.adapters.lldb = {
            type = 'executable',
            command = '/bin/lldb-vscode',
            name = 'lldb',
        }

        -- someone really thought python needs a debugger.
        dap.adapters.python = function(call_back, config)
            if config.request == 'attach' then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host
                call_back {
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                        source_filetype = 'python',
                    },
                }
            else
                call_back {
                    type = 'executable',
                    -- TODO: make it work with venv debugpy too
                    -- (it's an if statement and not that much usefull for me to make sense).
                    command = '/bin/python',
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
                    },
                }
            end
        end

        -- Am I a game dev too? hell no!
        dap.adapters.godot = {
            type = 'server',
            host = '127.0.0.1',
            port = 6006,
        }

        dap.adapters.delve = {
            type = 'server',
            port = '${port}',
            executable = 'dlv',
            args = { 'dap', '-l', '127.0.0.1:${port}' },
            -- If I was on window (not gonna happen)
            --detached = false,
        }

        dap.configurations.cpp = {
            {
                name = 'Luanch',
                request = 'launch',
                type = 'lldb',
                program = function()
                    return vim.fn.input {
                        prompt = 'Path to executable: ',
                        default = vim.fn.getcwd(),
                        completion = 'file',
                    }
                end,
                env = function()
                    local variables = {}
                    for k, v in pairs(vim.fn.environ()) do
                        table.insert(variables, string.format('%s=%s', k, v))
                    end
                    return variables
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                runInTermital = false,
            },
        }

        dap.configurations.c = dap.configurations.cpp

        dap.configurations.zig = {
            {
                name = 'Luanch',
                request = 'launch',
                type = 'lldb',
                program = function()
                    return vim.fn.input {
                        prompt = 'Path to executable: ',
                        default = vim.fn.getcwd() .. '/zig-out/bin/',
                        completion = 'file',
                    }
                end,
                env = function()
                    local variables = {}
                    for k, v in pairs(vim.fn.environ()) do
                        table.insert(variables, string.format('%s=%s', k, v))
                    end
                    return variables
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                runInTermital = false,
            },
        }

        dap.configurations.rust = {
            {
                name = 'Luanch',
                request = 'launch',
                type = 'lldb',
                program = function()
                    return vim.fn.input {
                        prompt = 'Path to executable: ',
                        default = vim.fn.getcwd() .. '/target/debug/',
                        completion = 'file',
                    }
                end,
                env = function()
                    local variables = {}
                    for k, v in pairs(vim.fn.environ()) do
                        table.insert(variables, string.format('%s=%s', k, v))
                    end
                    return variables
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                runInTermital = false,
                initCommands = function()
                    -- Find out where to look for the pretty printer Python module
                    local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')

                    local script_import = 'command script import "'
                        .. rustc_sysroot
                        .. '/lib/rustlib/etc/lldb_lookup.py"'

                    local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

                    local commands = {}
                    local file = io.open(commands_file, 'r')
                    if file then
                        for line in file:lines() do
                            table.insert(commands, line)
                        end
                        file:close()
                    end
                    table.insert(commands, 1, script_import)

                    return commands
                end,
            },
        }

        -- python again lol
        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = 'Launch file',

                program = '${file}', -- This configuration will launch the current file if used.
                pythonPath = function()
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return '/usr/bin/python'
                    end
                end,
            },
        }

        dap.configurations.gdscript = {
            {
                type = 'godot',
                request = 'launch',
                name = 'Launch scene',
                project = '${workspaceFolder}',
                launch_scene = true,
            },
        }

        dap.configurations.go = {
            {
                type = 'delve',
                name = 'Debug',
                request = 'launch',
                program = '${file}',
            },
            {
                type = 'delve',
                name = 'Debug test', -- configuration for debugging test files
                request = 'launch',
                mode = 'test',
                program = '${file}',
            },
            -- works with go.mod packages and sub packages
            {
                type = 'delve',
                name = 'Debug test (go.mod)',
                request = 'launch',
                mode = 'test',
                program = './${relativeFileDirname}',
            },
        }
    end,
}
