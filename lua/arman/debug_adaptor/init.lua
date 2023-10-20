local dap = vim.F.npcall(require, 'dap')
if dap == nil then
    return
end

dap.adapters.lldb = {
    type = 'executable',
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
    port = 6007,
}

dap.configurations.cpp = {
    name = 'Luanch',
    type = 'lldb',
    program = function()
        return vim.fn.input {
            prompt = 'Path to executable: ',
            default = vim.fn.getcwd() .. '/',
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
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
    name = 'Luanch',
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
        local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')

        local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
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
