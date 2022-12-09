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

-- Get the number of keys in tbl
local function NumOfKeys(tbl)
  local n = 0
  for _, _ in pairs(tbl) do
    n = n + 1
  end
  return n
end

-- Compare two tables and check whether they have same keys & values
-- NOTE: if value(s) are tables themselves, search recursively
function _G.CmpTables(t1, t2)
  if type(t1) ~= type(t2) then
    return false
  end
  if NumOfKeys(t1) ~= NumOfKeys(t2) then
    return false
  end
  for k, v in pairs(t1) do
    if type(v) == "table" then
      if not CmpTables(v, t2[k]) then
        return false
      end
    elseif v ~= t2[k] then
        return false
    end
  end
  return true
end
