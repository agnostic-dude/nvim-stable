-- aliases
local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

-- if lspconfig is not installed exit neovim
local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
  error("lspconfig is not installed", 2) -- throw back to caller
end

-- base capabilities provided by lspconfig
local capabilities = lspconfig.util.default_config.capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()

-- if nvim-cmp is installed grab capabilities provided by it
local cmp_ok, cmp_nvim = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = vim.tbl_deep_extend("force",
    capabilities, cmp_nvim.default_capabilities())
else
  print("need nvim-cmp to provide completion capabilities")
end

-- local capabilities = require("cmp_nvim_lsp").default_capabilities(
--   vim.lsp.protocol.make_client_capabilities()
-- )

local function on_attach(client, bufnr)

  -- TODO: fix below
  -- vim.api.nvim_buf_set_option("omnifunc", "v:vim.lsp.omnifunc", ??)

  -- Formatting: register autocommand to format LSP attached buffers on save
  if client.server_capabilities.documentFormattingProvider then
    create_autocmd("BufWritePre", {
      group = create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end,
    })
  end
end

return {
  on_attach = on_attach,
  capabilities = capabilities,
}
