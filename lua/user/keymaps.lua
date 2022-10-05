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
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'",
})

-- Exiting any neovim buffer: CapsLock Key ==> CapsLock Function
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'",
})

--> Map "lhs" keystrokes to "rhs" keystrokes, in NORMAL mode with default opts
local function nmap(lhs, rhs)
  vim.keymap.set("n", lhs, rhs, { remap = false, buffer = bufnr })
end

-- Map keys in NORMAL and INSERT modes
--> Map "lhs" keystrokes to "rhs" keystrokes, in INSERT mode with default opts
local function imap(lhs, rhs)
  vim.keymap.set("i", lhs, rhs, { remap = false, buffer = bufnr })
end

-- Navigate between Vertical splits in NORMAL mode
nmap("<C-l>", "<C-w>l")
nmap("<C-h>", "<C-w>h")

-- Ctrl-s to save in NORMAL & INSERT modes, and return to relavent mode
nmap("<C-s>", "<Cmd>w<CR>") --> nmap(...)
imap("<C-s>", "<Esc><Cmd>w<CR>a") --> imap(...)

-- Ctrl-q closes current split
nmap("<C-q>", "<C-w>q")

-- Clear highlighted text with <Escape> key
nmap("<Esc>", ":nohlsearch<Bar>:echo<CR>")

-- Captalize previous word in INSERT mode
imap("<C-u>", "<Esc>viwUea")

-- LEADER KEY (aka. <Leader>)
vim.g.mapleader = ";"
