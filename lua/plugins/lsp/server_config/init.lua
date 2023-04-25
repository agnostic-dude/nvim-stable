-------------------------------------------------------------------------------
-- Configurations for all language servers
-------------------------------------------------------------------------------
-- This dir contains config files for all installed servers. Server configs are
-- grouped according to the language.  This file sources all of them and creates
-- a table of server:configuration mappings.
-- NOTE: Code will break if/when you change the name of parent directory or any
-- of the its parents, because we use the path of parent dir here.  It cannot be
-- obtained at runtime!!!

local server_configs = {}
local parent_dir = vim.fn.stdpath("config") .. "/lua/plugins/lsp/server_config"
local configs = vim.fn.globpath(parent_dir, "*.lua", false, true)

if vim.tbl_isempty(configs) then
  vim.notify("could not find server configuration files!", ERROR,
    { title = "Server Configuration" })
  return 1
end

local modules = vim.tbl_map(
  function(o) return vim.fn.fnamemodify(o, ":t:r") end,
  configs
)

for _, config in ipairs(vim.tbl_filter(function(s) return s ~= "init" end, modules)) do
  local module_path = string.format("plugins.lsp.server_config.%s", config)
  server_configs = vim.tbl_extend("error", server_configs, require(module_path))
end

return server_configs