-------------------------------------------------------------------------------
-- Bash Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("bash-language-server") then
  servers.bashls = {
    -- empty config table
  }
end

return servers
