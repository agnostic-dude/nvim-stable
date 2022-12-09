-- null-ls.nvim config
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  print("null-ls.nvim is not installed..")
  return
end

local formatting = null_ls.builtins.formatting
local lsp_formatting = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  autostart = true,
  debug = true,
  sources = {
    formatting.black,
    formatting.prettier,
    formatting.clang_format,
    formatting.rustfmt,

    -- Stylua needs a project based stylua.toml or .stylua.toml
    -- formatting.stylua,

    -- TODO: error: lua-format is not executable (sumneko_lua can format now!)
    -- formatting.lua_format.with({
    --   extra_args = {
    --     "--no-keep-simple-function-one-line",
    --     "--no-break-after-operator",
    --     "--column-list=100",
    --     "--break-after-table-lb",
    --     "--indent-width=8",
    --   },
    -- }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = lsp_formatting, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_formatting,
        buffer = bufnr,
        callback = function(client)
          return client.name == "null-ls"
        end,
      })
    end
  end,
})
