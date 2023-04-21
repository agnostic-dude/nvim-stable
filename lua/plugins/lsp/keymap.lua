-------------------------------------------------------------------------------
-- Set keymappings for language servers
-------------------------------------------------------------------------------


-- Make keymappings for given LSP server for given buffer
local function set_keymap(client, bufnr)

  local function map(keys, func, opts, mode)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    mode = mode or "n" -- default to NORMAL mode
    vim.keymap.set(mode, keys, func, opts)
  end

  vim.notify("Registering keymaps for " .. client.name
    .. " for buffer " .. bufnr, INFO, { title = "Lspconfig-keymaps" })

  -- from nvim-lspconfig home page
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Hover: K
  map("K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

  -- Goto Definition: gd
  map("gd", function()
      vim.lsp.buf.definition({ reuse_win = true })
    end,
    { desc = "[g]oto [d]efinition" })

  -- Goto Declaration: gD
  map("gD", vim.lsp.buf.declaration, { desc = "[g]o to [D]eclaration" })

  -- Goto Type Definition: gt
  map("gt", vim.lsp.buf.type_definition, { desc = "[g]o to [t]ype definition" })

  -- List References: gr
  map("gr", vim.lsp.buf.references, { desc = "[g]o to [r]references" })

  -- Show function signature information: gi
  map("gi", vim.lsp.buf.signature_help, { desc = "[g]et signature [i]nformation" })

  -- List all implementations: gI
  map("gI", vim.lsp.buf.implementation,
    { desc = "[g]o to list of all [I]mplementations of the symbol" })

  -- Rename symbol: ;rn
  map("<Leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame symbol" })

  -- Select Code Action available at cursor position in NORMAL/VISUAL modes
  map("<Leader>ca", vim.lsp.buf.code_action,
    { desc = "[c]ode [a]ction" }, { "n", "v" })

  -- Show diagnostics in floating window: gl
  map("gl", vim.diagnostic.open_float,
    { desc = "[g]o to [l]ist in floating window" })

  -- Add buffer diagnostics to the location list: ;dl
  map("<Leader>dl", vim.diagnostic.setloclist,
    { desc = "Add buffer [d]iagnostics to location [l]ist" })

  -- Add all diagnostics to the quick-fix list: ;ql
  map("<Leader>ql", vim.diagnostic.setqflist,
    { desc = "Add all diagnostics to [q]uick-fix [l]ist" })

  -- Move to Previous Diagnostic: [d
  map("[d", vim.diagnostic.goto_prev,
    { desc = "goto [d]iagnostic [p]revious" })

  -- Move to Next Diagnostic: ]d
  map("]d", vim.diagnostic.goto_next,
    { desc = "goto [d]iagnostic [n]ext" })

  -- Set some key bindings conditional on server capabilities
  -------------------------------------------------------------------------------
  -- Format selected portion or whole of it: ;ff
  -- NOTE: until format-on-save works for lua
  -- If language server can format buffer...
  if client.server_capabilities.documentFormattingProvider then
    map("<Leader>%", vim.lsp.buf.format,
      { desc = "format buffer", async = true })
  end
end


return set_keymap
