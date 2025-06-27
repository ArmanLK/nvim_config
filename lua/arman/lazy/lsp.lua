---A custom init function for lsp server
local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

---A custom attach function for servers (some server might override this)
---@param client table
---@param bufnr integer
local custom_attach = function(client, bufnr)
    _ = client
    local opts = { buffer = bufnr, remap = false }
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(false)
    end
    vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = 1 } end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = -1 } end, opts)
    vim.keymap.set('i', '<c-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'lsp:hover', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>rr', '<cmd>LspRestart<cr>', opts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

local servers = {
    bashls = true,
    lua_ls = true,
    astro = true,
    gdscript = {
        flags = {
            debounce_text_changes = 100,
        },
    },
    html = true,
    pyright = true,
    ruff = true,
    pylsp = false,
    marksman = false,
    vimls = false,
    yamlls = false,
    ocamllsp = {
        --get_language_id = function(_, ftype)
        --    return ftype
        --end,
    },
    clojure_lsp = false,
    cmake = (1 == vim.fn.executable 'cmake-language-server'),
    clangd = {
        cmd = {
            'clangd',
            '--background-index',
            '--suggest-missing-includes',
            '--clang-tidy',
            '--header-insertion=iwyu',
        },
        init_options = {
            clangdFileStatus = true,
        },
    },
    svelte = false,
    gopls = {
        settings = {
            gopls = {
                codelenses = { test = true },
                hints = true and {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                } or nil,
            },
        },
        flags = {
            debounce_text_changes = 200,
        },
    },
    rust_analyzer = true,
    racket_langserver = false,
    elmls = false,
    cssls = false,
    tailwindcss = true,
    perlnavigator = false,
    jsonls = true,
    --tsserver = true,
    vtsls = true,
    eslint = true,
    zls = true,
    ols = true,
    texlab = true,

    glsl_analyzer = true,
}

return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    {
        'folke/lazydev.nvim',
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
        enabled = function(root_dir)
            _ = root_dir
            return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependecies = {
            'williamboman/mason.nvim',
            'folke/lazydev.nvim',
        },
        config = function()
            for server, config in pairs(servers) do
                if not config then
                    goto continue
                end
                if type(config) ~= 'table' then
                    config = {}
                end
                config = vim.tbl_deep_extend('force', {
                    on_init = custom_init,
                    on_attach = custom_attach,
                }, config)
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
                ::continue::
            end
        end,
    },
}
