--=========================================================================
-- Neovim Stable (version 0.8)
-- Plugin configuration: treesitter parser
--=========================================================================
vim.o.foldmethod = "expr"
vim.o.foldenable = true  -- enable folds when opening, `zi` to toggle
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 2      -- close folds with a higher foldlevel
vim.o.foldcolumn = "0"   -- make this "1" or "auto" to see fold numbers
vim.o.foldlevelstart = 0 -- folds closed: 0: all, 99: none, 1: some

require("nvim-treesitter.configs").setup({
  -- Installed parsers: "all" or a list
  ensure_installed = { "lua", "python", "c", "rust", "go", "vimdoc" },
  -- Install parsers synchronously
  sync_install = true,
  -- When entering a buffer automatically install missing parsers
  auto_install = true,
  indent = { enable = true },
  highlight = {
    enable = true, -- Core of Treesitter
    -- Enabling this might slow down vim.  And lead to highlighting issues,
    -- because highlight groups of ftplugin & treesitter are defined separately
    additional_vim_regex_highlighting = false, -- same as "syntax off"
  },
  --configs for nvim-ts-autotag
  autotag = {
    enable = true,
    filetypes = { "html", "xml" },
  },
})
