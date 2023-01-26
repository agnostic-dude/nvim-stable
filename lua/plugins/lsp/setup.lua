--=============================================================================
-- Neovim Stable (version 0.8)
-- Setting up builtin LSP to launch language servers
--=============================================================================
-- ISSUE: When 2 splits are opened with -O flag, first argument a text file &
-- second argument a python script, user defined keymaps (plugins.lsp.keymaps)
-- are not registered (as seen by output of :map). Need to LspRestart to amend
-- this problem.

local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
  vim.notify("Cannot proceed: lspconfig not installed", vim.log.levels.INFO)
  return
end

-- Get compilation of default capabilities & ones provided by nvim-cmp
-- cmp_nvim_lsp has more facilities for textDocument.completion; these are
-- added to defaults
local function Get_Capabilities()
  local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if cmp_nvim_lsp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    -- capabilities = vim.tbl_deep_extend("keep",
    --   cmp_nvim_lsp.default_capabilities(), capabilities)
  end
  capabilities.offsetEncoding = { "utf-16" } -- clangd uses utf-8 by default
  return capabilities
end

local Flags = {
  -- num of msec to wait before sending "UpdateDocument" request to server
  debounce_text_changes = 200, -- default = 150
}

-- callback function to execute when language server is attached to a buffer
local function On_Attach(client, bufnr)
  vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
  print(client.name .. " attached to buffer " .. bufnr)
end

-- additional settings for INDIVIDUAL language servers
local Settings = {
  sumneko_lua = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Get LSP to recognize "vim" global
      },
      workspace = {
        -- make server aware of neovim runtime files
        library = vim.api.nvim_get_runtime_file(".", true),
        checkThirdParty = false,
      },
      runtime = {
        version = "LuaJIT", -- Tell LSP which Lua version you're using
        path = vim.o.runtimepath,
      }
    },
  },
  rust_analyzer = {
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

local Servers = {
  "sumneko_lua",
  "tsserver",
  "pyright",
  "clangd",
  "rust_analyzer",
  "vimls",
  "gopls",
  "tailwindcss",
}

for _, server in ipairs(Servers) do
  lspconfig[server].setup({
    on_attach = On_Attach,

    -- This data is sent to language server to announce what features editor
    -- can support
    capabilities = Get_Capabilities(),

    flags = Flags,
    settings = Settings[server],
  })
end
