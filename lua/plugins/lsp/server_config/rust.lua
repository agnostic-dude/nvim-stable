-------------------------------------------------------------------------------
-- Rust Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("rust-analyzer") then
  servers.rust_analyzer = {
    imports = {
      granularity = {
        group = "module",
      },
      prefix = "self",
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
    checkOnSave = {
      command = "clippy",
    },
  }
end

return servers
