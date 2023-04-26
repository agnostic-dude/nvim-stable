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
local curr_file = GetCurrentFileName()
local parent_dir = vim.fn.fnamemodify(curr_file, ":h")
local config_files = vim.fn.globpath(parent_dir, "*.lua", false, true)

-- Remove this init file from list of config files
RemoveItem(config_files, curr_file)

-- If we cannot find any server config files complain and exit
if vim.tbl_isempty(config_files) then
  vim.notify("could not find any server configuration files", ERROR,
    { title = "Server Configuration" })
  return 1
end

-- Get `module` part of the file name
local modules = vim.tbl_map(
  function(o) return vim.fn.fnamemodify(o, ":t:r") end,
  config_files
)

-- Source each of the modules and add their config tables to list of configs.
-- Get relative path to parent directory from `lua` directory at runtime and
-- prepend it to each module name.
local _, i = parent_dir:find(vim.fn.stdpath("config") .. "/lua/")
local path_from_lua = parent_dir:sub(i + 1):gsub("/", ".")
for _, module in ipairs(modules) do
  local import_path = string.format("%s.%s", path_from_lua, module)
  server_configs = vim.tbl_extend("error", server_configs, require(import_path))
end

return server_configs
