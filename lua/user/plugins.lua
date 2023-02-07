--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: plugins
--=========================================================================
local function ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  -- if packer.nvim not found, git clone it
  if fn.empty(fn.glob(install_path)) == 1 then
    print("Installing packer for the first time...")
    fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
  function(use)
    -- self-manage packer plugin manager
    use("wbthomason/packer.nvim")

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter-textobjects",
      run = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
      end,
    })
    use("p00f/nvim-ts-rainbow") --> color matched parenthesis with treesitter
    use({
      "folke/trouble.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        "folke/lsp-colors.nvim", -- create highlight groups missing from theme
      },
    })

    -- colorschemes/themes
    use("NLKNguyen/papercolor-theme") -- Based on Google's Material Design
    use("folke/tokyonight.nvim") -- Ported from TokyoNight of VSCode
    use("navarasu/onedark.nvim") -- Based on Atom One dark & light themes
    use("liuchengxu/space-vim-theme") -- dark & light theme for space-vim
    use("rakr/vim-one") -- adaptation of one-light & one-dark
    use({ "metalelf0/jellybeans-nvim", -- a lua port of jellybeans for neovim
      requires = { "rktjmp/lush.nvim" } }
    )
    use("sainnhe/edge")

    use("norcalli/nvim-colorizer.lua") -- highlight colorcodes

    use("tpope/vim-commentary") -- comment/uncomment with gcc/gc
    use("jiangmiao/auto-pairs")
    use({ "windwp/nvim-autopairs", -- lua autopair plugin supporting multiple chars
      config = function()
        require("nvim-autopairs").setup {}
      end })
    use("windwp/nvim-ts-autotag") -- use treesitter to autoclose/rename HTTP tags
    use("lukas-reineke/indent-blankline.nvim")
    use("RRethy/vim-illuminate") --> smart highlighting of words under cursor

    --> Statusline
    use({ "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = false } })

    --> Git integration for buffers
    use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })

    use({ "akinsho/toggleterm.nvim", tag = "*" }) -- * avoids breaking changes

    -- Language-Server Protocol
    use({
      "neovim/nvim-lspconfig", -- configs for builtin LSP client
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        'j-hui/fidget.nvim',

        -- Additional lua configuration, makes nvim stuff amazing
        'folke/neodev.nvim',
      },
    })

    -- Autocompletion
    use({
      "hrsh7th/nvim-cmp", -- completion engine
      requires = {
        "hrsh7th/cmp-nvim-lsp", -- source for builtin LSP client
        "hrsh7th/cmp-buffer", -- complete words from current buffer
        "hrsh7th/cmp-path", -- complete file paths
        "hrsh7th/cmp-nvim-lua", -- completions for neovim API functions
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        { "L3MON4D3/LuaSnip", version = "<CurrentMajor>.*" },
      },
    })

    -- VSCode-like snippet collection
    use("rafamadriz/friendly-snippets")

    -- Using LSP to inject diagnostics, code-actions, formatting, hover,
    -- completion... from different tools
    use({ "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim" })

    -- Debugger Adapter Protocol (DAP)
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use("nvim-telescope/telescope-dap.nvim") -- Telescope support
    use("jbyuki/one-small-step-for-vimkind")
    use("mfussenegger/nvim-dap-python")
    use("leoluz/nvim-dap-go")

    --> Telescope
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kdheepak/lazygit.nvim", -- use Lazygit within neovim
      },
    })

    --> FZY type sorted for telescope
    use("nvim-telescope/telescope-fzy-native.nvim")
    use("romgrk/fzy-lua-native")

    -- Refactoring library based-off of book by Martin Fowler
    use({
      "ThePrimeagen/refactoring.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
    })

    -- File explorer
    use({ "nvim-tree/nvim-tree.lua", requires = "nvim-tree/nvim-web-devicons" })

    use("junegunn/vim-emoji") -- Emoji in vim
    use("onsails/lspkind-nvim") -- VSCode-like pictograms

    -- automatically setup configuration after cloning packer.nvim
    if packer_bootstrap then
      require("packer").sync()
    end
  end,

  -- Custom floating window to display packer command output
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "solid" })
      end,
    }
  },
})
