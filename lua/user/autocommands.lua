--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: autocommands
--==============================================================================

-------------------------------------------------------------------------------
--                      Redundant WHITESPACE
-------------------------------------------------------------------------------
-- Remove redundant whitespace at end-of-line, redundant newlines at end-of-file
local trim_whitespace = create_augroup("TrimWhitespace", { clear = true })

create_autocmd("FileType", {
  pattern = "*",
  command = "autocmd BufWritePre <buffer> %s/\\s\\+$//e",
  group = trim_whitespace,
})

create_autocmd("FileType", {
  pattern = "*",
  command = "autocmd BufWritePre <buffer> %s/\\($\\n\\s*\\)\\+\\%$//e",
  group = trim_whitespace,
})

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
-- Source relevant skeleton source file
-- Source relevant skeleton file
-------------------------------------------------------------------------------
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

-- Regenerate compiled loader file each time plugins config is updated
create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile | echo 'regenerated loader file'",
  desc = "Regenerate loader file on config update",
  group = create_augroup("PackerCompileOnUpdate", { clear = true })
}
)

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
create_autocmd("VimEnter", {
  desc = "Register auto-pairs Fly Mode to activate",
  pattern = "*",
  callback = function()
    if packer_plugins["auto-pairs"] then
      vim.g.AutoPairsFlyMode = 1
      vim.g.AutoPairsShortcutBackInsert = "<C-b>"
    end
  end,
  group = create_augroup("ActivateAutoPairsFlyMode", { clear = true }),
})
