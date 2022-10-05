--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: plugins
--=========================================================================
local function ensure_packer_installed()
    local fn = vim.fn
    local install_path = fn.stdpath('data')
        .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system {
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path,
        }
        vim.cmd [[ packadd packer.nvim ]]
        return true
    end
    return false
end

local packer = require "packer"
local packer_bootstrap = ensure_packer_installed()

return packer.startup(function(use)
    -- Manage package manager
    use "wbthomason/packer.nvim"

    -- Persistant, toggled floating terminals
    use "akinsho/toggleterm.nvim"


    -- At end of all plugins to automatically setup configuration after
    -- clonning packer.nvim
    if packer_bootstrap then
        packer.sync()
    end
end)
