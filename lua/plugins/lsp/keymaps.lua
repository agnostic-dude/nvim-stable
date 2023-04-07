-- New keymaps

local utils = require("plugins.lsp.utils")
local nmap = utils.Nmap
local imap = utils.Imap

local function map_keys(client, bufnr)
  vim.notify("Registering keymaps for " .. client.name
    .. " for buffer " .. bufnr)

  -- Hover: K
  nmap("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")

  -- Goto Definition: gd
  nmap("gd", function()
    vim.lsp.buf.definition({ reuse_win = true })
  end,
    bufnr, "[g]oto [d]efinition")

  -- Goto Declaration: gD
  nmap("gD", vim.lsp.buf.declaration, bufnr, "[g]o to [D]eclaration")

  -- Goto Type Definition: gt
  nmap("gt", vim.lsp.buf.type_definition, bufnr, "[g]o to [t]ype definition")

  -- List References: gr
  nmap("gr", vim.lsp.buf.references, bufnr, "[g]o to [r]references")

  -- Show function signature information: gi
  nmap("gi", vim.lsp.buf.signature_help, bufnr, "[g]et signature [i]nformation")

  -- List all implementations: gI
  nmap("gI", vim.lsp.buf.implementation, bufnr,
    "[g]o to list of all [I]mplementations of the symbol")

  -- Rename symbol: ;rn
  nmap("<Leader>rn", vim.lsp.buf.rename, bufnr, "[r]e[n]ame symbol")

  -- Select Code Action available at cursor position: ;ca
  nmap("<Leader>ca", vim.lsp.buf.code_action, bufnr, "[c]ode [a]ction")
  imap("<Leader>ca", vim.lsp.buf.range_code_action, bufnr, "[c]ode [a]ction")

  -- Format selected portion or whole of it: ;ff
  -- NOTE: until format-on-save works for lua
  nmap("<Leader>%", vim.lsp.buf.format, bufnr, "[f]ormat [f]ile")

  -- Show diagnostics in floating window: gl
  nmap("gl", vim.diagnostic.open_float, bufnr,
    "[g]o to [l]ist in floating window")

  -- Add buffer diagnostics to the location list: ;dl
  nmap("<Leader>dl", vim.diagnostic.setloclist, bufnr,
    "Add buffer [d]iagnostics to location [l]ist")

  -- Add all diagnostics to the quick-fix list: ;ql
  nmap("<Leader>ql", vim.diagnostic.setqflist, bufnr,
    "Add all diagnostics to [q]uick-fix [l]ist")

  -- Move to Previous Diagnostic: ;dp
  nmap("<Leader>dp", vim.diagnostic.goto_prev, bufnr,
    "goto [d]iagnostic [p]revious")

  -- Move to Next Diagnostic: ;dn
  nmap("<Leader>dn", vim.diagnostic.goto_next, bufnr,
    "goto [d]iagnostic [n]ext")
end

return {
  Register = map_keys,
}
