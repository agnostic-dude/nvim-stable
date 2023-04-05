--=============================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: plugins
--=============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
  },
  "p00f/nvim-ts-rainbow", -- color matched parenthesis with treesitter
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/lsp-colors.nvim", -- create highlight groups missing from theme
    },
  },

  -- colorschemes/themes
  { "NLKNguyen/papercolor-theme", -- Based on Google's Material Design
    lazy = false,
    priority = 1000,
    config = function()
      if vim.fn.has("termguicolors") then
        vim.o.termguicolors = true
        vim.cmd([[ colorscheme PaperColor ]])
      end
    end,
  },
  "folke/tokyonight.nvim", -- Ported from TokyoNight of VSCode
  "liuchengxu/space-vim-theme", -- dark & light theme for space-vim
  { "metalelf0/jellybeans-nvim", -- a lua port of jellybeans for neovim
    dependencies = { "rktjmp/lush.nvim" } },

  "sainnhe/edge",
  "arturgoms/moonbow.nvim", -- inspired by gruvbox & ayu dark

  "norcalli/nvim-colorizer.lua", -- highlight colorcodes

  "tpope/vim-commentary", -- comment/uncomment with gcc/gc
  "tpope/vim-surround", -- delete/change/add quotes, parens, XML tags
  "jiangmiao/auto-pairs",
  "lukas-reineke/indent-blankline.nvim",
  "RRethy/vim-illuminate", --> smart highlighting of words under cursor
  { "junegunn/goyo.vim", ft = "markdown" }, -- distraction free writing
  "vimwiki/vimwiki",

  --> Statusline
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" } },

  --> Git integration for buffers
  { "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },

  { "akinsho/toggleterm.nvim" }, -- * avoids breaking changes

  -- Language-Server Protocol
  {
    "neovim/nvim-lspconfig", -- configs for builtin LSP client
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- signature help, docs & completion for neovim lua API
      'folke/neodev.nvim',
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp", -- completion engine
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- source for builtin LSP client
      "hrsh7th/cmp-buffer", -- complete words from current buffer
      "hrsh7th/cmp-path", -- complete file paths
      "hrsh7th/cmp-nvim-lua", -- completions for neovim API functions
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      { "L3MON4D3/LuaSnip", version = "<CurrentMajor>.*", build = "make install_jsregexp" },
    },
  },

  -- VSCode-like snippet collection
  "rafamadriz/friendly-snippets",

  -- Using LSP to inject diagnostics, code-actions, formatting, hover,
  -- completion... from different tools
  { "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim" },

  -- Debugger Adapter Protocol (DAP)
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-telescope/telescope-dap.nvim", -- Telescope support
  "jbyuki/one-small-step-for-vimkind",
  "mfussenegger/nvim-dap-python",
  "leoluz/nvim-dap-go",

  --> Telescope
  { "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kdheepak/lazygit.nvim", -- use Lazygit within neovim
    },
  },

  --> fzf fuzzy finder for telescope
  --> NOTE: This does not make the binary "libfzf.so", you have to go to the
  --> plugin directory and run make manually
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Refactoring library based-off of book by Martin Fowler
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- File explorer
  { "nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons" },

  "junegunn/vim-emoji", -- Emoji in vim
  "onsails/lspkind-nvim", -- VSCode-like pictograms
})
