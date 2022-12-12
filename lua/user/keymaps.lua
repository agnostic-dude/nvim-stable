--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: keymappings
--==============================================================================

-------------------------------------------------------------------------------
--                  Mapping ESCAPE key to CAPSLOCK
-------------------------------------------------------------------------------
-- Map <Escape> key to <CapsLock> for easy typing (using xmodmap)
-- CAUTION: If >= 2 buffers are open, exiting from one buffer alone undoes this
-- mapping. You also will not have the use of Caps-Lock key!
--
-- Entering any neovim buffer: CapsLock Key ==> Escape Function
local remap_capslock = vim.api.nvim_create_augroup("RemapCapsLock", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'",
  desc = "map CapsLock to Esc on entry",
  group = remap_capslock,
})

-- Exiting any neovim buffer: CapsLock Key ==> CapsLock Function
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'",
  desc = "restore CapsLock on exit",
  group = remap_capslock,
})

-- Setup global LEADER key
vim.g.mapleader = ";"

-- Navigate between splits in NORMAL mode without CTRL+w
nnoremap("<C-l>", "<C-w>l") --> Goto split on left
nnoremap("<C-h>", "<C-w>h") --> Goto split on right
nnoremap("<C-j>", "<C-w>j") --> Goto split below
nnoremap("<C-k>", "<C-w>k") --> Goto split above

-- * Transform a horizontal split to a vertical split (e.g. help pages)
-- NOTE: Assumes command is launched from a vertical split below first window
nnoremap("<Leader>hv", "<C-w>t<C-w>H<C-w>l")
-- * Transform a vertical split to a horizontal split
-- NOTE: Assumes command is run from a horizontal split to right of first one
nnoremap("<Leader>vh", "<C-w>t<C-w>K<C-w>j")

-- Ctrl-s to save in NORMAL & INSERT modes, and return to relavent mode
nnoremap("<C-s>", "<Cmd>w<CR>")
inoremap("<C-s>", "<Esc><Cmd>w<CR>a")

-- Ctrl-q closes current split, without CTRL+w
nnoremap("<C-q>", "<C-w>q")

-- Clear highlighted text with <Escape> key
nnoremap("<Esc>", "<cmd>nohlsearch<Bar>:echo<CR>")

-- In INSERT mode;
-- <C-u> deletes everything from cursor to the start of the line (UNDO LINE)
-- <C-w> deletes the word before the cursor (UNDO WORD),
inoremap("<C-l>", "<Esc>viwUea") -- Captalize previous WORD

-- -- Map ":" in NORMAL mode to open a command-line window ready for work
-- nnoremap(":", "q:i")
nnoremap("<C-c>", "<cmd>tabclose<cr>")
nnoremap("gn", "<cmd>tabnext<cr>") -- by default "gT"
nnoremap("gp", "<cmd>tabprevious<cr>") -- by default "gT"

-- Go up/down the page, keeping cursor in the middle of the screen
-- credit Primagen
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
