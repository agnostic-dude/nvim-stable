-- Alternative setup.lua
-- This is the only file that is sourced directly by init.lua to setup the LSP
-- configuration
--=============================================================================
-- Neovim Stable (version 0.8)
-- Setting up builtin LSP to launch relevant language server & attach buffer
--=============================================================================
local keymaps = require("plugins.lsp.keymaps")

local function on_attach(client, bufnr)
  keymaps.Register(client, bufnr)

  vim.api.nvim_buf_create_user_command(bufnr,
    "Format", vim.lsp.buf.format,
    { desc = "Format current buffer with LSP" }
  )
end

-------------------------------------------------------------------------------
-- Customize diagnostic icons
-------------------------------------------------------------------------------
local function change_diagnostic_sign(opts)
  vim.fn.sign_define(opts.name, {
    text = opts.text,
    texthl = opts.name,
    numhl = "",
  })
end

local diagnostic_signs = {
  error   = { name = "DiagnosticSignError", text = "🕱 " },
  hint    = { name = "DiagnosticSignHint", text = "💡" },
  info    = { name = "DiagnosticSignInfo", text = "ⓘ " },
  warning = { name = "DiagnosticSignWarn", text = "⚠" },
}

for _, opts in pairs(diagnostic_signs) do
  change_diagnostic_sign(opts)
end

-- Configure diagnostic messages and the like
vim.diagnostic.config({
  -- virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  }
})


-- Setup mason so it can manage external tooling
local neodev_ok, neodev = pcall(require, "neodev")
if neodev_ok then
  neodev.setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
  })
end

-- Turn on lsp status information
local fidget_ok, fidget = pcall(require, 'fidget')
if fidget_ok then
  fidget.setup()
end

local servers = require("plugins.lsp.servers")
local mason = require("plugins.lsp.mason")

-------------------------------------------------------------------------------
-- Capabilities
-------------------------------------------------------------------------------
-- nvim-cmp supports additional completion capabilities, so broadcast that
-- to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
  -- extend default capabilities
  cmp_nvim_lsp.default_capabilities(capabilities)
else
  vim.notify("Needs cmp_nvim_lsp", vim.log.levels.ERROR)
end
capabilities.offsetEncoding = { "utf-16" } -- clangd uses utf-8 by default

if mason ~= nil then
  mason.setup()
  mason.lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers)
  })

  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
  if lspconfig_ok then
    mason.lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          flags = {
            -- num of milliseconds to wait before next "updateDocument" request
            -- is sent to the language server (default is 150ms)
            debounce_text_changes = 250,
          },
        })
      end,
    })
  else
    vim.notify("Need to install lspconfig", vim.log.levels.ERROR)
  end
else
  vim.notify("Need to install mason", vim.log.levels.ERROR)
end

-- Setup completion engine
require("plugins.lsp.cmp")

-- Setup null-ls for non-LSP tools, if it is available
require("plugins.lsp.null")
