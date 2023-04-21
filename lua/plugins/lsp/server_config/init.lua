-------------------------------------------------------------------------------
-- Configurations for all language servers
-------------------------------------------------------------------------------

-- Get a list of all config files in this directory (named after languages).
-- Source all of them and create a table of server-configuration mappings.
local server_configs = {}
local cur_dir = vim.fn.stdpath("config") .. "/lua/plugins/lsp/server_config"
local configs = vim.fn.globpath(cur_dir, "*.lua")
local modules = vim.tbl_map(
  function(o) return vim.fn.fnamemodify(o, ":t:r") end,
  vim.fn.split(configs)
)

for _, config in ipairs(vim.tbl_filter(function(s) return s ~= "init" end, modules)) do
  local module_path = string.format("plugins.lsp.server_config.%s", config)
  server_configs = vim.tbl_extend("error", server_configs, require(module_path))
end

return server_configs
