local function bufmap(mode, keys, func, bufnr, desc)
  if desc then
    desc = "LSP: " .. desc
  end
  vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
end

-- Map `keys` keyboard shortcut to `func` lua function in NORMAL mode
local function nmap(keys, func, bufnr, desc)
  bufmap("n", keys, func, bufnr, desc)
end

-- Map `keys` keyboard shortcut to `func` lua function in INSERT mode
local function imap(keys, func, bufnr, desc)
  bufmap("i", keys, func, bufnr, desc)
end

return {
  Nmap = nmap,
  Imap = imap,
}
