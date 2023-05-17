-------------------------------------------------------------------------------
-- CSS Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("vscode-css-language-server") then
  servers.cssls = {
    -- empty config table
  }
end

return servers
