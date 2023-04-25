-- null-ls.nvim config
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    vim.notify("Needs to install null-ls", WARN, { title="null_ls-config" })
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local lsp_formatting = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {

  -- Python
  formatting.black.with({ max_line_length = "80" }),
  formatting.isort,
  diagnostics.pylint, -- +simple refactoring

  -- Javascript
  formatting.prettierd.with({
    disabled_filetypes = { "html" } -- reserve HTML formatting for tidy
  }),

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
    -- lua-format is shite! (lua_ls can format now!)
    -- formatting.lua_format.with({
    --     extra_args = {
    --         -- "--indent-width=8",
    --         "--no-keep-simple-function-one-line", "--no-break-after-operator",
    --         "--column-limit=80", "--break-after-table-lb",
    --         "--single-quote-to-double-quote", "--chop-down-parameter",
    --         "--continuation-indent-width=2"
    --     }
    -- }),

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

local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({group = lsp_formatting, buffer = bufnr})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_formatting,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    format_options = {
                      insertFinalNewline = true,
                    },
                    -- filter available formatters so that only null-ls receives request
                    filter = function(lspclient)
                        return lspclient.name ~= "lua_ls" or lspclient.name == "null-ls"
                    end
                })
            end
        })
    end
end

null_ls.setup({
    autostart = true,
    debug = true,
    sources = sources,
    on_attach = on_attach
})
