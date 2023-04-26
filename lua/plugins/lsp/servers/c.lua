-------------------------------------------------------------------------------
-- C Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("clangd") then
  servers.clangd = {
    filetypes = { "c", "cpp", "cc" },
    flags = {
      debounce_text_changes = 500,
    },
  }
end

return servers
