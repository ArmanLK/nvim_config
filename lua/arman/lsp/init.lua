local neodev = vim.F.npcall(require, 'neodev')
if neodev then
    neodev.setup {
        lspconfig = true,
        pathStrict = true,
    }
end
local lspconfig = vim.F.npcall(require, 'lspconfig')
if not lspconfig then
    return
end
require('mason').setup()

local autocmd_clear = vim.api.nvim_clear_autocmds
--local ts_util = require "nvim-lsp-ts-utils"
local inlays = require 'arman.lsp.inlay'
local handlers = require 'arman.lsp.handlers'
---A function for creating vim autocmd
local autocmd = function(args)
    local event = args[1]
    local group = args[2]
    local callback = args[3]

    vim.api.nvim_create_autocmd(event, {
        group = group,
        callback = function()
            callback()
        end,
        once = args.once,
    })
end

---A custom init function for lsp server
local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup('custom-lsp-references', { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup('custom-lsp-codelens', { clear = true })
local augroup_format = vim.api.nvim_create_augroup('custom-lsp-format', { clear = true })

---Autocommand for formating file asyncronous (or not)
---@param async boolean
---@param filter function|nil
local autocmd_format = function(async, filter)
    vim.api.nvim_clear_autocmds { group = augroup_format }
    vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
            vim.lsp.buf.format { async = async, filter = filter }
        end,
    })
end

local filetype_attach = setmetatable({
    ocaml = function()
        autocmd_format(false)
        -- Display type information
        autocmd_clear { group = augroup_codelens }
        print 'arman.lsp.codelens'
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'CursorHold' }, {
            group = augroup_codelens,
            callback = require('arman.lsp.codelens').refresh_virtlines,
        })
        vim.keymap.set(
            'n',
            '<leader>tt',
            require('arman.lsp.codelens').toggle_virtlines,
            { silent = true, desc = '[T]oggle [T]ypes' }
        )
    end,
    go = function()
        autocmd_format(false)
    end,
    css = function()
        autocmd_format(false)
    end,
    rust = function()
        autocmd_format(false)
    end,
    typescript = function()
        autocmd_format(false, function(client)
            return client.name ~= 'tsserver'
        end)
    end,
    javascript = function()
        autocmd_format(false, function(client)
            return client.name ~= 'tsserver'
        end)
    end,
    python = function()
        autocmd_format(false)
    end,
}, {
    __index = function()
        return function() end
    end,
})

---A custom attach function for servers (some server might override this)
---@param client table
---@param bufnr integer
local custom_attach = function(client, bufnr)
    -- require 'inlay-hints'.on_attach(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
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
    set('n', '<leader>gI', handlers.implementation, opts)
    --set('n', '<leader>lr', require('arman.lsp.codelens').run, opts)
    set('n', '<leader>rr', '<cmd>LspRestart<cr>', opts)
    set('n', '<leader>lr', vim.lsp.buf.references, opts)
    set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        autocmd_clear { group = augroup_highlight, buffer = bufnr }
        autocmd { 'CursorHold', augroup_highlight, vim.lsp.buf.document_highlight, bufnr }
        autocmd { 'CursorMoved', augroup_highlight, vim.lsp.buf.clear_references, bufnr }
    end
    if false and client.server_capabilities.codeLensProvider then
        if filetype ~= 'elm' then
            autocmd_clear { group = augroup_codelens, buffer = bufnr }
            autocmd { 'BufEnter', augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true }
            autocmd { { 'BufWritePost', 'CursorHold' }, augroup_codelens, vim.lsp.codelens.refresh, bufnr }
        end
    end
    -- Attach any filetype specific options to the client
    filetype_attach[filetype]()
end

-- local rust_analyzer = nil
-- local has_rt, rt = pcall(require, "rust-tools")
-- if has_rt then
--     rt.setup {
--         server = {
--             capabilities = updated_capabilities,
--             on_attach = custom_attach,
--         },
--     }
-- else
--     rust_analyzer = {
--         settings = {
--             ["rust-analyzer"] = {
--                 checkOnSave = {
--                     command = "clippy",
--                 },
--             },
--         },
--     }
-- end

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
    marksman = true,
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
                hints = inlays and {
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

---Sets servers up
---@param server string
---@param config table | boolean
local setup_server = function(server, config)
    if not config then
        return
    end
    if type(config) ~= 'table' then
        config = {}
    end
    config = vim.tbl_deep_extend('force', {
        on_init = custom_init,
        on_attach = custom_attach,
    }, config)
    lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end
