--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: utility functions
--==============================================================================

local Utils = {}

-- Map "lhs" keystrokes to "rhs" keystrokes, in NORMAL mode non-recurively
function Utils.nnoremap(lhs, rhs)
  vim.keymap.set("n", lhs, rhs, { remap = false })
end

-- Map "lhs" keystrokes to "rhs" keystrokes, in INSERT mode non-recurively
function Utils.inoremap(lhs, rhs)
  vim.keymap.set("i", lhs, rhs, { remap = false })
end

return Utils
