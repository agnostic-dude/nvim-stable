--=============================================================================
-- Neovim Nightly Edtion (version 0.8)
-- Show indentation guides in colors of rainbow
--=============================================================================
--> Copied from github.com

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#55CC66 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#1520A6 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#B90E0A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent7 guifg=#FAEFAE gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent8 guifg=#630436 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent9 guifg=#DDFFEE gui=nocombine]]


vim.opt.list = false --> hide whitespace characters
vim.opt.listchars:append("eol:↲")
vim.opt.listchars:append("tab:━━")
vim.opt.listchars:append("nbsp:+")
vim.opt.listchars:append("trail:●")
vim.opt.listchars:append("extends:≫")
vim.opt.listchars:append("precedes:≪")

require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}
