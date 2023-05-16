--=============================================================================
-- LSP configuration
-- DONE: This file is supposed to collect all server configs and setup the LSP
-- servers.
-- Server configs live in `server_config` directory. Requiring this will get a
-- list of config tables, each table having settings for one language server.
--=============================================================================

local user_config = require("plugins.lsp.config")
local server_configs = require("plugins.lsp.servers")

local mason_installed, mason = pcall(require, "mason")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_installed then
  mason.setup()
  if mason_lspconfig_ok then
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(server_configs)
    })
  end
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if lspconfig_ok then
  if mason_lspconfig_ok then
    mason_lspconfig.setup_handlers({
      function(server)
        lspconfig[server].setup(
          vim.tbl_extend("error", server_configs[server], user_config)
        )
      end
    })
  else
    vim.notify("mason-lspconfig is not installed", WARN, { title = "LSP Config" })
    for server, config in pairs(server_configs) do
      lspconfig[server].setup(vim.tbl_extend("error", config, user_config))
    end
  end
else
  vim.notify("lspconfig not installed", ERROR, { title = "LSP Config" })
  return 1
end

-- Setup autocompletion
require("plugins.lsp.cmp")

-- Setup null-ls server
require("plugins.lsp.null")

-- Setup custom code folding
local ufo_installed, ufo = pcall(require, "ufo")
if ufo_installed then
  ufo.setup()
else
  vim.notify("nvim-ufo not installed", WARN, { title = "Code Folding" })
end
