local function bufmap(mode, lhs, rhs)
    local opts = { buffer = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

vim.api.nvim_create_autocmd("User", {
    pattern = "LspAttached",
    desc = "LSP Actions",
    callback = function(client, bufnr)
        -- Listing of keymappings for LSP client

        -- Inspect symbol under the cursor
        bufmap("n", "K", vim.lsp.buf.hover) -- reveal symbol on hover
        bufmap("n", "gd", vim.lsp.buf.definition) -- go to definition
        bufmap("n", "gt", vim.lsp.buf.type_definition) -- go to type definition
        bufmap("n", "gi", vim.lsp.buf.implementation) -- list implementations
        bufmap("n", "gD", vim.lsp.buf.declaration) -- go to declaration
        bufmap("n", "gr", vim.lsp.buf.references) -- list references
        bufmap("n", "gs", vim.lsp.buf.signature_help) -- show signature info

        -- Rename symbol under the cursor for the whole project
        bufmap("n", "<Leader>rn", vim.lsp.buf.rename)

        -- Select & perform code action at current cursor position or chunk
        bufmap("n", "<Leader>ca", vim.lsp.buf.code_action)
        bufmap("x", "<Leader>ca", vim.lsp.buf.range_code_action)

        -- Show diagnostics in a floating window
        bufmap("n", "<Leader>dl", vim.diagnostic.open_float)

        -- Move between diagnostics
        bufmap("n", "<Leader>dn", vim.diagnostic.goto_next)
        bufmap("n", "<Leader>dp", vim.diagnostic.goto_prev)

        -- Format text in a file/region
        bufmap("n", "<Leader>fx", vim.lsp.buf.format)
        bufmap("x", "<Leader>fx", vim.lsp.buf.range_formatting)

        -- if client.supports_method("textDocument/formatting") then
        --     vim.api.nvim_create_autocmd("BufWritePre", {

        --         -- use this as a callback if want to setup formatting on save
        --         group = vim.api.nvim_create_augroup("LspBufFormat"),
        --         buffer = bufnr,
        --         callback = function()
        --             vim.lsp.buf.format({
        --                 filter = function()
        --                     return client.name == "null_ls"
        --                 end,
        --                 bufnr = bufnr,
        --             })
        --         end
        --     })
        -- end
    end,
})
