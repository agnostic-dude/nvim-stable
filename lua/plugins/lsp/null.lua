-- null-ls.nvim config
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  vim.notify("Needs to install null-ls", vim.log.levels.WARN)
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local lsp_formatting = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  autostart = true,
  debug = true,
  sources = {
    -- Python
    formatting.black.with({
      max_line_length = "80",
    }),
    formatting.isort,
    diagnostics.pylint, -- +simple refactoring

    -- Javascript
    formatting.prettierd.with({
      disabled_filetypes = { "html" } -- reserve HTML formatting for tidy
    }),

    -- HTML/XML
    formatting.tidy.with({
      extra_args = { "-wrap", "80", "-indent", "auto" },
    }),

    -- Rust
    formatting.rustfmt,

    -- Go
    formatting.gofmt,
    diagnostics.golangci_lint.with({
      args = { "run", "--fix=false", "--out-format=json", "$DIRNAME",
        "--path-prefix", "$ROOT" },
      extra_args = { "-c", vim.fn.getenv("GOPATH") .. "/utils/.golangci.yml" },
    }),

    -- Lua
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

    -- Shell
    formatting.shfmt,
    formatting.beautysh,
    diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

    -- Git
    code_actions.gitsigns, -- provide code actions from GitSigns

    -- Fix common misspellings
    formatting.codespell,

    -- trim newlines (simple wrapper around awk)
    formatting.trim_newlines,

    -- trim trailing whitespace (simple wrapper around awk)
    formatting.trim_whitespace,
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = lsp_formatting, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_formatting,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            -- filter available formatters so that only null-ls receives request
            filter = function()
              return client.name ~= "sumneko_lua" and client.name == "null-ls"
            end
          })
        end,
      })
    end
  end,
})
