local lspconfig = require("lspconfig")
local config = require("plugins.lsp.config")

-- Lua language server
lspconfig.sumneko_lua.setup({
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

-- TypeScript language server
lspconfig.tsserver.setup({
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "typescript", "javascript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
})
