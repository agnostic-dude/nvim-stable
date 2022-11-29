-- Map keys as follows on attach of new LSP server
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()

    local function bufmap(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = true })
    end

    -- Hover
    bufmap("n", "K", vim.lsp.buf.hover)

    -- Goto Definition
    bufmap("n", "gd", vim.lsp.buf.definition)

    -- Goto Declaration
    bufmap("n", "gD", vim.lsp.buf.declaration)

    -- Goto Type Symbol Definition
    bufmap("n", "gt", vim.lsp.buf.type_definition)

    -- List References
    bufmap("n", "gr", vim.lsp.buf.references)

    -- List all implementations
    bufmap("n", "gi", vim.lsp.buf.implementation)

    -- Show function signature information
    bufmap("n", "gI", vim.lsp.buf.signature_help)

    -- Rename symbol
    bufmap("n", "rn", vim.lsp.buf.rename)

    -- Select Code Action available at cursor position
    bufmap("n", "<Leader>ca", vim.lsp.buf.code_action)
    bufmap("i", "<Leader>ca", vim.lsp.buf.range_code_action)

    -- Show diagnostics in floating window
    bufmap("n", "gl", vim.diagnostic.open_float)

    -- Move to Previous Diagnostic
    bufmap("n", "dp", vim.diagnostic.goto_prev)

    -- Move to Next Diagnostic
    bufmap("n", "dn", vim.diagnostic.goto_next)

  end,

})
