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
--> like nnoremap
local function nmap(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { remap = false, buffer = false })
end

-- Map keys in NORMAL and INSERT modes
--> Map "lhs" keystrokes to "rhs" keystrokes, in INSERT mode with default opts
--> like inoremap
local function imap(lhs, rhs)
    vim.keymap.set("i", lhs, rhs, { remap = false, buffer = false })
end

-- Navigate between Vertical splits in NORMAL mode
nmap("<C-l>", "<C-w>l") --> Move to split on Left
nmap("<C-h>", "<C-w>h") --> Move to split on Right
nmap("<C-k>", "<C-w>k") --> Move to split on Up
nmap("<C-j>", "<C-w>j") --> Move to split on Down

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

-- Change colorschems
nmap("<Leader>nc", "<cmd>CycleColorNext<cr>") -- Next Color
nmap("<Leader>pc", "<cmd>CycleColorPrev<cr>") -- Previous Color
nmap("<Leader>cs", "<cmd>colorscheme<cr>") -- Colorscheme Show

local function SwitchBackground()
    if vim.o.background == "dark" then
        vim.o.background = "light"
        print("Switched to light background")
    else
        vim.o.background = "dark"
        print("Switched to dark background")
    end
end

nmap("<Leader>sb", SwitchBackground) -- switch background dark <-> light

-------------------------------------------------------------------------------
-- Telescope.nvim
-------------------------------------------------------------------------------
local telescope = prequire("telescope.builtin")
if telescope then
    -- File pickers
    nmap("<Leader>ff", telescope.find_files)
    nmap("<Leader>fg", telescope.live_grep)
    nmap("<Leader>fb", telescope.buffers)
    nmap("<Leader>fh", telescope.help_tags)
    nmap("<Leader>fs", telescope.grep_string)

    -- Git pickers
    nmap("<Leader>gc", telescope.git_commits)
    nmap("<Leader>gC", telescope.git_bcommits)
    nmap("<Leader>gb", telescope.git_branches)
    nmap("<Leader>gs", telescope.git_status)
    nmap("<Leader>gS", telescope.git_stash)

    -- Treesitter picker
    nmap("<Leader>tp", telescope.treesitter)
end
