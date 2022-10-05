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

  --> Utilities for coding
  use "jiangmiao/auto-pairs" --> autocomplete & link parenthesis
  use "tpope/vim-commentary" --> gc/gcc to comment/uncomment
  use "lukas-reineke/indent-blankline.nvim" --> show indentation levels
  use "RRethy/vim-illuminate" --> smart highlighting of words under cursor

  --> Statusline
  use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true } }

  --> Git support
  use { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" }

  --> Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = "<Cmd>TSUpdate" }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "p00f/nvim-ts-rainbow" --> colors matched parenthesis using treesitter


  --> Cycle through all colorschemes
  use "vim-scripts/CycleColor" --> cycle through colorschemes in rtp

  --> Colorschemes
  use "joshdick/onedark.vim" --> theme inspired by Atom
  use "folke/tokyonight.nvim" --> TokyoNight colorscheme for VSCode
  use "tomasiser/vim-code-dark" --> inspired by Dark+ scheme of VSCode
  use "NLKNguyen/papercolor-theme" --> inspired by Google's Material Design
  use "liuchengxu/space-vim-theme" --> dark & light with GUI support

    -- At end of all plugins to automatically setup configuration after
    -- clonning packer.nvim
    if packer_bootstrap then
        print("Need to restart neovim after installation")
        packer.sync()
    end
end)
