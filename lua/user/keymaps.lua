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

-- Ctrl-q closes current split, without CTRL+w
Nnoremap("<C-q>", "<C-w>q")

-- Ctrl-s to save in NORMAL & INSERT modes, and return to relevant mode
Nnoremap("<C-s>", "<Cmd>w<CR>")
Inoremap("<C-s>", "<Esc><Cmd>w<CR>a")

-- Navigate between splits in NORMAL mode without CTRL+w
Nnoremap("<C-l>", "<C-w>l") --> Goto split on left
Nnoremap("<C-h>", "<C-w>h") --> Goto split on right
Nnoremap("<C-j>", "<C-w>j") --> Goto split below
Nnoremap("<C-k>", "<C-w>k") --> Goto split above

-- * Transform a horizontal split to a vertical split (e.g. help pages)
-- NOTE: Assumes command is launched from a vertical split below first window
Nnoremap("<Leader>hv", "<C-w>t<C-w>H<C-w>l")
-- * Transform a vertical split to a horizontal split
-- NOTE: Assumes command is run from a horizontal split to right of first one
Nnoremap("<Leader>vh", "<C-w>t<C-w>K<C-w>j")

-- Clear currently highlighted text with <Escape> key
Nnoremap("<Esc>", "<cmd>nohlsearch<Bar>:echo<CR>")

-- Source current file
Nnoremap("<M-s>", "<cmd>source %<cr>", { desc = "Source current file" })

-- In INSERT mode;
-- <C-u> deletes everything from cursor to the start of the line (UNDO LINE)
-- <C-w> deletes the word before the cursor (UNDO WORD),
Inoremap("<C-l>", "<Esc>viwUea") -- Captalize previous WORD

-- -- Map ":" in NORMAL mode to open a command-line window ready for work
-- nnoremap(":", "q:i")
Nnoremap("<C-c>", "<cmd>tabclose<cr>")
Nnoremap("gn", "<cmd>tabnext<cr>") -- by default "gT"
Nnoremap("gp", "<cmd>tabprevious<cr>") -- by default "gT"

-- Go up/down the page, keeping cursor in the middle of the screen
-- credit to Primeagen
Nnoremap("<C-d>", "<C-d>zz")
Nnoremap("<C-u>", "<C-u>zz")

-- Toggle Nvim-Tree
Nnoremap("<Leader>tt", "<cmd>NvimTreeToggle<cr>")
Nnoremap("<Leader>tf", "<cmd>NvimTreeFocus<cr>")

-- From "nvim-lua/kickstart.nvim"
-- Make j/k move up/down using "visual" lines instead of actual lines, even when
-- lines are wrapped with window splitting, when motion is not prepended by a
-- count (e.g. k, not with 10k). Uses gk/gj instead of k/j, respectively, when
-- a line count is not given.
local opts = { expr = true, silent = true }
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", opts)

-- Toggle/untoggle distraction-free writing with goyo.vim
Nnoremap("<Leader>gy", "<cmd>Goyo<cr>")
