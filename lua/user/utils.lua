--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: utility functions
-- This module puts aliases for some commonly used functions into global
-- namespace.
--==============================================================================

-- Map "lhs" keystrokes to "rhs" keystrokes, in NORMAL mode non-recurively
function _G.Nnoremap(lhs, rhs, opts)
  opts = vim.tbl_extend("keep", { remap = false }, opts or {})
  vim.keymap.set("n", lhs, rhs, opts)
end

-- Map "lhs" keystrokes to "rhs" keystrokes, in INSERT mode non-recurively
function _G.Inoremap(lhs, rhs, opts)
  opts = vim.tbl_extend("keep", { remap = false }, opts or {})
  vim.keymap.set("i", lhs, rhs, opts)
end

-- Map "lhs" keystrokes to "rhs" keystrokes, in VISUAL mode non-recurively
function _G.Vnoremap(lhs, rhs, opts)
  opts = vim.tbl_extend("keep", { remap = false }, opts or {})
  vim.keymap.set("v", lhs, rhs, opts)
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

-- TODO: Bind custom notification function with async support if available as
-- vim.notify
-- If nvim-notify plugin is available use it to show notifications
function _G.notify(notification, log_level)
  local has_async, async = pcall(require, "plenary.async")
  local has_notify, notify = pcall(require, "notify")

  if has_notify then
    if has_async then
      vim.notify = notify.async
    else
      vim.notify = notify
    end
  end
end

-- alias used log levels for convenience
_G.ERROR = vim.log.levels.ERROR
_G.WARN = vim.log.levels.WARN
_G.INFO = vim.log.levels.INFO
_G.DEBUG = vim.log.levels.DEBUG

-- Means for any file to get its own name
function _G.GetCurrentFileName()
  local source = debug.getinfo(2, "S").source
  if source:sub(1, 1) == "@" then
    return source:sub(2)
  else
    return error("Caller was not defined in a file", 2)
  end
end

-- Remove item from a list (vector table)
-- NOTE: This function modifies the list in-place, does not return anything
function _G.RemoveItem(tbl, item)
  for i = 1, #tbl do
    if tbl[i] == item then
      table.remove(tbl, i)
    end
  end
end
