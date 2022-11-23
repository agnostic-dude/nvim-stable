--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: autocommands
--==============================================================================

local inoremap = require("user.utils").inoremap
local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

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
  callback = function() inoremap("</", "</<C-x><C-o>") end,
})

-- Source relavent skeleton source file
create_autocmd("BufNewFile", {
  pattern = "*.py",
  command = "0read ~/.local/share/nvim/templates/template.py",
})

create_autocmd("BufNewFile", {
  pattern = "*.html",
  command = "0read ~/.local/share/nvim/templates/template.html",
})

-- Regenerate compiled loader file each time plugins config is updated
create_autocmd("BufWritePost", {
pattern = "plugins.lua",
command = "source <afile> | PackerCompile | echo 'regenerated loader file'",
desc = "Regenerate loader file on config update",
group = create_augroup("PackerCompileOnUpdate", { clear = true })
}
)
