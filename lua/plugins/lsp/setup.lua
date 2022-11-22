--=============================================================================
-- Neovim Stable (version 0.8)
-- Configuration for builtin LSP
--=============================================================================

local lspconfig = require "lspconfig"
local cmp_nvim  = require "cmp_nvim_lsp"

-- options shared between ALL language servers
local lsp_defaults = {
    flags = {
        -- number of miliseconds to wait before sending next "Update Document"
        -- Document" notification to language server (default = 150ms)
        debounce_text_changes = 250,
    },
    -- this data is sent to language server to announce what features editor
    -- can support
    capabilites = cmp_nvim.default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    ),

    -- callback function to execute when language server is attached to a buffer
    on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds("User", {pattern = "LspAttached"})
        print(client.name .. " attached to buffer " .. bufnr)
    end,
}
-- additional settings for INDIVIDUAL language servers
local lsp_settings = {
    sumneko_lua = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            } },
    },
    ["rust-analyzer"] = {
        imports = {
            granularity = {
                group = "module",
            },
            prefix = "self",
        },
        cargo = {
            buildScripts = {
                enable = true,
            },
        },
        procMacro = {
            enable = true,
        },
        checkOnSave = {
            command = "clippy",
        },
    },
}

-- merge our default LSP configuration with global configuration of lspconfig
lspconfig.util.default_config = vim.tbl_deep_extend(
    "force", -- if key is duplicated, use value from latter
    lspconfig.util.default_config, -- global configuration of lspconfig
    lsp_defaults
)

lspconfig.sumneko_lua.setup({
    single_file_support = true,
    on_attach = lsp_defaults.on_attach,
    -- on_attach = function(client, bufnr)
    --     lspconfig.util.default_config.on_attach(client, bufnr)
    -- end,
    settings = lsp_settings.sumneko_lua,
    -- capabilities = lsp_defaults.capabilities,
})

lspconfig.pyright.setup({
    -- on_attach = lsp_defaults.on_attach,
    -- capabilities = lsp_defaults.capabilities,
})

lspconfig.rust_analyzer.setup({
    settings = lsp_settings["rust-analyzer"],
})

lspconfig.clangd.setup({})
