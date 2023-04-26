-------------------------------------------------------------------------------
-- Go Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("gopls") then
  servers.gopls = {
    -- empty config table
  }
end

return servers
