--=========================================================================
-- Neovim Stable (version 0.8)
-- Plugin configuration: treesitter parser
--=========================================================================
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true, -- Core of Treesitter

    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  }
})
