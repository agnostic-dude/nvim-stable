--=============================================================================
-- Neovim Stable (version 0.8)
-- Setting up builtin LSP
--=============================================================================

local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
  error("Cannot proceed: lspconfig not installed", 2) -- throw back to caller
end

-- Get compilation of default capabilities & ones provided by nvim-cmp
local function get_capabilities()
  local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if cmp_nvim_lsp_ok then
    capabilities = vim.tbl_deep_extend("keep",
      cmp_nvim_lsp.default_capabilities(), capabilities)
  end
  return capabilities
end

-- options shared between ALL language servers
local lsp_defaults = {
  flags = {
    -- number of miliseconds to wait before sending next "Update Document"
    -- Document" notification to language server (default = 150ms)
    debounce_text_changes = 250,
  },
  -- this data is sent to language server to announce what features editor
  -- can support
  capabilities = get_capabilities(),

  -- callback function to execute when language server is attached to a buffer
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
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
