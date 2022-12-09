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

  indent = { enable = false }, -- turning on messes up with indentation, unless
  -- additional_vim_regex_highlighting (see below) is turned on as well.

  highlight = {
    enable = true, -- Core of Treesitter

    -- Enabling this might slow down vim.  And lead to highlighting issues,
    -- because highlight groups of ftplugin & treesitter are defined separately
    additional_vim_regex_highlighting = false, -- same as "syntax off"
  },
})
