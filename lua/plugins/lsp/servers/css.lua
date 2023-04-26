-------------------------------------------------------------------------------
-- CSS Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("tailwindcss-language-server") then
  servers.tailwindcss = {
    -- empty config table
  }
end


return servers
