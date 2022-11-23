--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: settings
--=========================================================================
local o = vim.opt
local g = vim.g

-- Whitespace
o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4 -- indentation

-- Indentation
o.cindent = true
o.breakindent = true

-- Text dispaly area setup
o.textwidth = 80 -- max line length
o.wrapmargin = 2 -- chars to left of border when wrapping starts
o.signcolumn = 'auto' -- hide signcolumn if there is nothing to show
o.colorcolumn = '+0' -- highlight last legal column

-- Show line numbers
o.number = true

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Save undo history
o.undofile = true

-- Graphical
g.mouse = 'a'
o.digraph = true
o.cursorline = true -- highlight the line cursor is on

-- Split windows
o.splitright = true
o.splitbelow = true
