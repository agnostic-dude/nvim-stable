--=============================================================================
-- Neovim Stable (version 0.8)
-- LSP diagnostics configuration
--=============================================================================
-- Change the symbols that appear on signcolumn
local signs = {
    Error = "🕱", --> 🄴   ⓔ  Ⓔ  ☠ 🗴 🗵 🗶 🗷
    Warn = "⚠", -->  🅆  ⓦ  Ⓦ
    Hint = "💡", -->  ⓗ  🄷  Ⓗ
    Info = "ⓘ", -->  Ⓘ  🄸  🔑 🗝 🛈
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Most severe DiagnosticSign is shown in gutter per line
-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#customize-lsp-codelens-and-signs
vim.diagnostic.config {
  virtual_text = {
    source = "always",
    prefix = "🔎", --> alternatives 🗒 🟕 🛆  ⧋ ⛛  ■ ✰  ⮿  ⚑ 🟖 ◉
    -- Only show virtual text matching the given severity
    severity = {
      -- Specify a range of severities
      min = vim.diagnostic.severity.ERROR,
    },
  },
  float = {
    source = "always",
    border = "rounded",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true
}
