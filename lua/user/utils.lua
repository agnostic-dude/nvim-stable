--========================================================================
-- Neovim Stable (version 0.8)
-- Configuration file in Lua
--========================================================================
_G.prequire = function (plugin_name, verbose)
    local plugin_found, plugin = pcall(require, plugin_name)
    if plugin_found then
        return plugin
    end
    local errmsg = string.format("Could not load %s", plugin_name)
    if verbose then
        errmsg = string.format("%s\nError: %s", plugin)
    end
    print(errmsg)
end
