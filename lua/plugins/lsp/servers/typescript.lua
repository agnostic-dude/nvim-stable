-------------------------------------------------------------------------------
-- TypeScript Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("typescript-language-server") then
  servers.tsserver = {
    -- empty config table
  }
end


return servers
