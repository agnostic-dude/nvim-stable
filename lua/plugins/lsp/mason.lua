--============================================================================
-- Neovim Stable (version 0.8)
-- Plugin configuration: mason config
-- Exports a table. If we do not have mason installed this table is empty. If
-- we have mason-lspconfig installed, table will have a `lspconfig` key that
-- maps to symbols exported by mason-lspconfig
--============================================================================
local M = {}

-- setup mason so that it can manage external tooling
local mason_ok, mason = pcall(require, "mason")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

if mason_ok then
  M = mason
  if mason_lspconfig_ok then
    M.lspconfig = mason_lspconfig
  end
end

return M
