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

return require("packer").startup(function(use)
  -- self-manage packer plugin manager
  use("wbthomason/packer.nvim")

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- themes
  use("NLKNguyen/papercolor-theme") -- Based on Google's Material Design
  use("folke/tokyonight.nvim") -- Ported from TokyoNight of VSCode
  use("Mofiqul/vscode.nvim") -- Based on Dark+ & Light+ of VSCode
  use("navarasu/onedark.nvim") -- Based on Atom One dark & light themes
  use("liuchengxu/space-vim-theme") -- dark & light theme for space-vim
  use("sainnhe/sonokai") -- high-contrast based on Monokai Pro

  use("tpope/vim-commentary") -- comment/uncomment with gcc/gc
  use("jiangmiao/auto-pairs") -- insert/delete quotes, parens, brackets in pairs
  use("lukas-reineke/indent-blankline.nvim")

  use({ "akinsho/toggleterm.nvim", tag = "*" }) -- * avoids breaking changes

  -- Language-Server Protocol
  use("neovim/nvim-lspconfig") -- configs for builtin LSP client
  use("hrsh7th/nvim-cmp") -- completion
  use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
  use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for builtin LSP


  -- automatically setup configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
