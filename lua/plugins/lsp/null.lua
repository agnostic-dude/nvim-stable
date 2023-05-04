-- null-ls.nvim config
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  vim.notify("null-ls is not installed", WARN,
    { title = "Null-ls Configuration" })
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local null_sources = {

  -- Python
  formatting.black.with({ max_line_length = "80" }),
  formatting.isort,
  diagnostics.pylint, -- +simple refactoring

  -- Javascript/Typescript
  formatting.prettier.with({
    disabled_filetypes = { "html" } -- reserve HTML formatting for tidy
  }),
  diagnostics.eslint_d,
  diagnostics.jshint,
  diagnostics.jsonlint,

  -- HTML/XML
  formatting.tidy.with({ extra_args = { "-wrap", "80", "-indent", "auto" } }),

  -- Rust
  formatting.rustfmt,

  -- Go
  formatting.gofmt, diagnostics.golangci_lint.with({
  args = {
    "run", "--fix=false", "--out-format=json", "$DIRNAME",
    "--path-prefix", "$ROOT"
  },
  extra_args = { "-c", vim.fn.getenv("GOPATH") .. "/utils/.golangci.yml" }
}),

  -- Lua
  -- lua-format is shite, stylua needs project based config files!
  -- (PLUS lua_ls can format now!, let's use that)

  -- Shell
  formatting.shfmt,
  formatting.beautysh,
  diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
  code_actions.shellcheck,

  -- Refactoring library based on book by Martin Fowler
  -- using thePrimeagen/refactoring.nvim plugin
  code_actions.refactoring,

  -- Git
  code_actions.gitsigns, -- provide code actions from GitSigns

  -- Fix common misspellings
  formatting.codespell,

  -- trim newlines & whitespace (simple wrapper around awk)
  formatting.trim_newlines,
  formatting.trim_whitespace,
}

local lspconfig = require("plugins.lsp.config")

null_ls.setup({
  autostart = true,
  debug = true,
  sources = null_sources,
  on_attach = lspconfig.on_attach
})
