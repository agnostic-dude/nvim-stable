-------------------------------------------------------------------------------
-- Vim Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("vim-language-server") then
  servers.vimls = {
    flags = {
      debounce_text_changes = 500,
    }
  }
end

return servers
