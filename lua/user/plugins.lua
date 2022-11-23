--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: plugins
--=========================================================================
local function ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  -- if packer.nvim not found, git clone it
  if fn.empty(fn.glob(install_path)) then
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
    local ts_update = require("nvim-treesitter.install").update({with_sync=true})
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

  use("tpope/vim-commentary")
  use({ "windwp/nvim-autopairs",
  config = function() require("nvim-autopairs").setup() end,
  })
  use("lukas-reineke/indent-blankline.nvim")
  


  -- automatically setup configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
