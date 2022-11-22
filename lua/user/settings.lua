--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: settings
--=========================================================================
local o = vim.opt
local g = vim.g

-- Whitespace
o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4

-- Indentation
o.cindent = true
o.breakindent = true

-- Text dispaly area setup
o.textwidth = 80 -- max line length
o.wrapmargin = 1 -- chars to left of border when wrapping starts
o.signcolumn = 'auto' -- hide signcolumn if there is nothing to show
o.colorcolumn = '+0' -- highlight last legal column

-- Show line numbers
o.number = true
o.relativenumber = true

-- cursor movement
g.startofline = true -- move cursor to first non-blank line with Ctrl-DUBF

-- window splitting
o.splitright = true -- open new vertical splits to right of current one
o.splitbelow = true -- open new horizontal splits below current one

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Save undo history
o.undofile = true

-- Dictionary
o.dictionary = "/usr/share/dict/words"

-- Enable 24-bit RGB colors in TUI
if vim.fn.has("termguicolors") then
    o.termguicolors = true
end

-- Graphical
g.mouse = 'a'
o.digraph = true
o.cursorline = true -- highlight the line cursor is on

-- Required for nvim-cmp
o.completeopt = { "menu", "menuone", "noselect" }

-- Colorscheme
vim.cmd [[ colorscheme PaperColor ]]
