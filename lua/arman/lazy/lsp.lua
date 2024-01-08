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
    local set = vim.keymap.set
    set('n', '<leader>ld', vim.diagnostic.open_float, opts)
    set('n', '[d', vim.diagnostic.goto_next, opts)
    set('n', ']d', vim.diagnostic.goto_prev, opts)
    set('i', '<c-s>', vim.lsp.buf.signature_help, opts)
    set('n', '<leader>ln', vim.lsp.buf.rename, opts)
    set('n', '<leader>la', vim.lsp.buf.code_action, opts)
    set('n', '<leader>lf', vim.lsp.buf.format, opts)
    set('n', 'gd', vim.lsp.buf.definition, opts)
    set('n', 'gD', vim.lsp.buf.declaration, opts)
    set('n', 'gT', vim.lsp.buf.type_definition, opts)
    set('n', 'K', vim.lsp.buf.hover, { desc = 'lsp:hover', buffer = bufnr, remap = false })
    --set('n', '<leader>lr', require('arman.lsp.codelens').run, opts)
    set('n', '<leader>rr', '<cmd>LspRestart<cr>', opts)
    set('n', '<leader>lr', vim.lsp.buf.references, opts)
    set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

local servers = {
    bashls = true,
    lua_ls = true,
    astro = true,
    eslint = false,
    gdscript = {
        flags = {
            debounce_text_changes = 100,
        },
    },
    html = true,
    pyright = true,
    ruff_lsp = true,
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
    csharp_ls = true,
    rust_analyzer = true,
    racket_langserver = false,
    elmls = false,
    cssls = true,
    perlnavigator = false,
    jsonls = true,
    tsserver = true,
    zls = true,
    ols = true,
}

return {
    'williamboman/mason.nvim',
    'folke/neodev.nvim',
    'simrat39/inlay-hints.nvim',
    {
        'neovim/nvim-lspconfig',
        dependecies = {
            'williamboman/mason.nvim',
            'folke/neodev.nvim',
            'simrat39/inlay-hints.nvim',
        },
        config = function()
            local lspconfig = require 'lspconfig'

            require('neodev').setup {
                lspconfig = true,
                pathStrict = true,
            }

            require('mason').setup()

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
                lspconfig[server].setup(config)
                ::continue::
            end
            require('inlay-hints').setup {
                -- renderer to use
                -- possible options are dynamic, eol, virtline and custom
                renderer = 'inlay-hints/render/dynamic',

                hints = {
                    parameter = {
                        show = true,
                        --highlight = "whitespace",
                    },
                    type = {
                        show = true,
                    },
                },
                -- Only show inlay hints for the current line
                only_current_line = false,

                eol = {
                    -- whether to align to the extreme right or not
                    right_align = false,
                    -- padding from the right if right_align is true
                    right_align_padding = 7,
                    parameter = {
                        separator = ' ',
                        format = function(hints)
                            return string.format('<- (%s)', hints)
                        end,
                    },
                    type = {
                        separator = ' ',
                        format = function(hints)
                            return string.format('=> %s', hints)
                        end,
                    },
                },
            }

            -- TODO: this still doesn't work
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('my-inlay-hints', {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require('inlay-hints').on_attach(client, args.buf)
                end,
            })
        end,
    },
}
