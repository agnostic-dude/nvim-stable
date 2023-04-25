--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: settings
--=========================================================================

local options = {
  -- Whitespace
  expandtab = true,
  softtabstop = 4,
  shiftwidth = 4, -- indentation
  cindent = true,
  breakindent = true,
  textwidth = 80,      -- max line length
  signcolumn = "auto", -- hide signcolumn if there is nothing to show
  colorcolumn = "+0",  -- highlight last legal column
  number = true,       -- show line numbers
  -- search settings
  ignorecase = true,
  smartcase = true,
  undofile = true,
  -- Graphical
  mouse = "a",
  digraph = false,   -- disabled to prevent non-ASCII chars on command line
  cursorline = true, -- highlight the line cursor is on
  splitright = true,
  splitbelow = true,
  dictionary = "/usr/share/dict/allwords.txt"
}

for option, value in pairs(options) do
  vim.opt[option] = value
end

vim.cmd([[filetype plugin indent on]])

-- UI theme in 24-bit RGB color TUI
if vim.fn.has("termguicolors") then
  vim.o.termguicolors = true
else
  vim.notify("Terminal does not have GUI colors", vim.log.levels.WARN, { title="nvim-settings-config" })
end
