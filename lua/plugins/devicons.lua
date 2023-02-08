-- Lua fork of vim-devicons
-- This adds all the highlight groups for the devicons. i.e. it calls
-- vim.api.nvim_set_hl for all icons.
-- NOTE: This might need to be called AGAIN, in a Colorscheme to re-apply
-- cleared highlights if the colorscheme changes.
require("nvim-web-devicons").setup({
  override = {
    zsh = {
      icon = " ",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh",
    }
  },
  color_icons = true,

  default = true,
})
