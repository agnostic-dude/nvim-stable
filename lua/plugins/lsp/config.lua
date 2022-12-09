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
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim.default_capabilities())
else
  print("need nvim-cmp to provide completion capabilities")
end

-- local capabilities = require("cmp_nvim_lsp").default_capabilities(
--   vim.lsp.protocol.make_client_capabilities()
-- )
-- NOTE: transferred from null-ls config
local lsp_formatting = create_augroup("LspFormatting", { clear=true })

local function on_attach(client, bufnr)
  -- TODO: fix below
  -- vim.api.nvim_buf_set_option("omnifunc", "v:vim.lsp.omnifunc", ??)

  -- Formatting: register autocommand to format LSP attached buffers on save
  -- if client.server_capabilities.documentFormattingProvider then
  -- NOTE: transferred from null-ls config
  if client.supports_method("textDocument/formatting") then
    -- if client.name == "sumneko_lua" then
    --   client.server_capabilities.document_formatting = false
    --   client.server_capabilities.document_range_formatting = false
    -- end
    vim.api.nvim_clear_autocmds({group=lsp_formatting, buffer=bufnr})
    create_autocmd("BufWritePre", {
      group = lsp_formatting,
      buffer = bufnr,
      callback = function(client)
        return client.name == "null-ls"
      end,
    })
  end
end

return {
  on_attach = on_attach,
  capabilities = capabilities,
}
