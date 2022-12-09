--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: utility functions
-- This module puts aliases for some commonly used functions into global
-- namespace.
--==============================================================================

-- Map "lhs" keystrokes to "rhs" keystrokes, in NORMAL mode non-recurively
function _G.nnoremap(lhs, rhs)
  vim.keymap.set("n", lhs, rhs, { remap = false })
end

-- Map "lhs" keystrokes to "rhs" keystrokes, in INSERT mode non-recurively
function _G.inoremap(lhs, rhs)
  vim.keymap.set("i", lhs, rhs, { remap = false })
end

_G.create_autocmd = vim.api.nvim_create_autocmd
_G.create_augroup = vim.api.nvim_create_augroup
