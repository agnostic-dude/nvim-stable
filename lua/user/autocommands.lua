--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: autocommands
--==============================================================================

-------------------------------------------------------------------------------
--                        LINE NUMBERS
-------------------------------------------------------------------------------
-- Toggle/untoggle relative/absolute line numbers depending on active/inactive
-- state of the buffers.
local numbertoggle = create_augroup("NumberToggle", { clear = true })

-- relative line numbers in active buffer
create_autocmd(
    { "BufEnter", "FocusGained", "InsertLeave" },
    { pattern = "*", command = "set relativenumber", group = numbertoggle }
)

-- absolute line numbers in inactive buffer
create_autocmd(
    { "BufLeave", "FocusLost", "InsertEnter" },
    { pattern = "*", command = "set norelativenumber", group = numbertoggle }
)

-------------------------------------------------------------------------------
--                        Custom AUTO-PAIRS
-------------------------------------------------------------------------------
-- Make AutoPairs understand python F-strings & byte strings
create_autocmd("FileType", {
  pattern = "python",
  command = [[ let b:AutoPairs = AutoPairsDefine({ "f'": "'", "b'": "'", "r'": "'"}) ]]
})

-- AutoPairs for rust
create_autocmd("FileType", {
  pattern = "rust",
  command = [[ let b:AutoPairs = AutoPairsDefine({ 'r#"': '"#', "\w\zs<": ">", "|": "|"}) ]]
})

-- Make AutoPairs understand markup language angle brackets
create_autocmd("FileType", {
  pattern = { "html", "xml" },
  command = [[  let b:AutoPairs = AutoPairsDefine({ '<': '>' }) ]]
})

-- Auto-complete HTML tags with omnicomplete
create_autocmd("FileType", {
  pattern = "html",
  -- command = "inoremap </ </<C-x><C-o>",
  callback = function() Inoremap("</", "</<C-x><C-o>") end,
})

-------------------------------------------------------------------------------
-- Source relevant skeleton file
-------------------------------------------------------------------------------

create_autocmd("BufNewFile", {
  pattern = "*.sh",
  command = "0read ~/.local/share/nvim/skeletons/skeleton.sh",
})

create_autocmd("BufNewFile", {
  pattern = "*.py",
  command = "0read ~/.local/share/nvim/skeletons/skeleton.py",
})

create_autocmd("BufNewFile", {
  pattern = "*.html",
  command = "0read ~/.local/share/nvim/skeletons/skeleton.html",
})

create_autocmd("BufNewFile", {
  pattern = "*.go",
  command = "0read ~/.local/share/nvim/skeletons/skeleton.go",
})

-- AUTO-PAIRS "FLY-MODE"
-- Auto-pairs "Fly Mode" enables jumping out of nested closed pairs easier.
-- Works for ), ] &  }. Instead of inserting parentheses.
-- Press "g:AutoPairsBackInsert" key (default <M-b>) to jump back
-- and insert closed pair.
--
-- WHY AN AUTOCOMMAND? WHY NOT A CONFIGURATION FILE?
-- Before we setup config for "auto-pairs", we need to test if "auto-pairs" is
-- installed. The way to check this is using global table "packer_plugin".
-- But this table is only visible after "packer_compiled.lua" is loaded, which
-- it turns out is AFTER user config (init.lua) is sourced, BUT before VimEnter
-- autocommands are executed. Therefore, this will not work in a config file.
-- UPDATE: using lazy.nvim instead of packer.nvim as plugin manager
create_autocmd("VimEnter", {
  desc = "Register auto-pairs Fly Mode to activate",
  pattern = "*",
  callback = function()
    local lazy = require("lazy")
    if not vim.tbl_isempty(lazy) and vim.tbl_contains(vim.tbl_map(
          function(plugin)
            return plugin.name
          end,
          lazy.plugins()), "auto-pairs") then
      vim.g.AutoPairsFlyMode = 1
      vim.g.AutoPairsShortcutBackInsert = "<C-b>"
    end
  end,
  group = create_augroup("ActivateAutoPairsFlyMode", opts),
})

-- move cursor to the last position it was, when the file was last opened
-- source: https://builtin.com/software-engineering-perspectives/neovim-configuration
create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd([[ execute  "normal! g'\"" ]])
    end
  end,
})

-- Announce when colorscheme is changed
create_autocmd("ColorScheme", {
  desc = "announce change of colorscheme",
  callback = function()
    local new_colorscheme = vim.fn.expand("<amatch>")
    vim.notify("switched to " .. new_colorscheme,
      INFO, { title = "Colorscheme" })
  end,
  group = create_augroup("ColorschemeChange", opts),
})
