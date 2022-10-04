--=============================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: settings
--=============================================================================
local o = vim.opt
local g = vim.g

-- Whitespace
o.expandtab = true

-- Indentation
o.cindent = true
o.breakindent = true

-- Text dispaly area setup
o.textwidth = 79 -- max line length
o.wrapmargin = 0 -- chars to left of border when wrapping starts
o.signcolumn = 'yes'
o.colorcolumn = '+1'

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
