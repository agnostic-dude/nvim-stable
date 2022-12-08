--=========================================================================
-- Neovim Stable (version 0.8)
-- Plugin configuration: treesitter parser
--=========================================================================
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false -- enable to fold on opening

require("nvim-treesitter.configs").setup({
  -- Installed parsers: "all" or a list
  ensure_installed = { "lua", "python", "c", "rust" },

  -- Install parsers synchronously
  sync_install = true,

  -- When entering a buffer automatically install missing parsers
  auto_install = true,

  highlight = {
    enable = true, -- Core of Treesitter

    additional_vim_regex_highlighting = false,
  },
})
