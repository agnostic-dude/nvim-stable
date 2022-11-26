local lsp_ok, lsp = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

local function on_attach(client, bufnr)

  -- vim.api.nvim_buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- formatting
  if client.server_capabilities.documentFormattingProvider then
    create_autocmd("BufWritePre", {
      group = create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end,
    })
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

return {
  on_attach = on_attach,
  lsp = lsp,
  capabilities = capabilities,
}
