--=============================================================================
-- Lsp Configuration
--=============================================================================

-------------------------------------------------------------------------------
--                  LSP Server Capabilities
-------------------------------------------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_ok then
  -- add extra functionality if available
  capabilities = vim.tbl_deep_extend("force",
    capabilities, cmp_nvim_lsp.default_capabilities())
else
  vim.notify("cmp-nvim-lsp is not installed", WARN,
    { title = "LSP Client Sources" })
end

capabilities.offsetEncoding = { "utf-16" } -- clangd uses utf-8 by default

-------------------------------------------------------------------------------
--                  LSP Server On Attach Callback
-------------------------------------------------------------------------------
local set_keymappings = require("plugins.lsp.keymap")

local function on_attach(client, bufnr)
  -- setup keymappings
  set_keymappings(client, bufnr)

  if client.server_capabilities.documentFormattingProvider then
    local format_on_save = vim.api.nvim_create_augroup("FormatOnSave",
      { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_on_save,
      buffer = bufnr,
      callback = function(ev)
        vim.lsp.buf.format({
          async = false, -- ISSUE: if TRUE, async writing never saves the file!
          bufnr = ev.buf,
          format_options = { insertFinalNewline = true },
          -- filter = function(lspclient)
          -- NOTE: can we use a table to store client.id, and exclude null-ls
          -- if client.id is already registered with lua_ls?
          --   if lspclient.name == "lua_ls" then
          --     return true
          --   else
          --     return lspclient.name == "null-ls"
          --   end
          -- end,
        })
      end,
      desc = client.name .. " format buffer " .. bufnr,
    })
  else
    vim.notify(client.name .. " cannot format documents", WARN,
      { title = "Lspconfig" })
  end
end


-------------------------------------------------------------------------------
--              Customize LSP Diagnostic Icons
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
  hint    = { name = "DiagnosticSignHint", text = "" }, -- 💡
  info    = { name = "DiagnosticSignInfo", text = "ⓘ " },
  warning = { name = "DiagnosticSignWarn", text = "⚠" },
}

for _, opts in pairs(diagnostic_signs) do
  change_diagnostic_sign(opts)
end

-------------------------------------------------------------------------------
--              Customize LSP Diagnostic Messages
-------------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  }
})


-- neodev.nvim
-- fidget.nvim


return {
  on_attach = on_attach,
  capabilities = capabilities,
}
