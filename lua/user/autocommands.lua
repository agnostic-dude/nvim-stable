--==============================================================================
-- Neovim Stable Edtion (version 0.8)
-- Lua configuration: autocommands
--==============================================================================

-------------------------------------------------------------------------------
--                      Redundant WHITESPACE
-------------------------------------------------------------------------------
-- Remove redundant whitespace at end-of-line, redundant newlines at end-of-file
local trim_whitespace = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "autocmd BufWritePre <buffer> %s/\\s\\+$//e",
  group = trim_whitespace,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "autocmd BufWritePre <buffer> %s/\\($\\n\\s*\\)\\+\\%$//e",
  group = trim_whitespace,
})

-------------------------------------------------------------------------------
--                        LINE NUMBERS
-------------------------------------------------------------------------------
-- Toggle/untoggle relative/absolute line numbers depending on active/inactive
-- state of the buffers.
local numbertoggle = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

-- relative line numbers in active buffer
vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave" },
  { pattern = "*", command = "set relativenumber", group = numbertoggle }
)

-- absolute line numbers in inactive buffer
vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter" },
  { pattern = "*", command = "set norelativenumber", group = numbertoggle }
)

-------------------------------------------------------------------------------
--                        Custom AUTO-PAIRS
-------------------------------------------------------------------------------
-- Make AutoPairs understand python F-strings & byte strings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = [[ let b:AutoPairs = AutoPairsDefine({ "f'": "'", "b'": "'", "r'": "'"}) ]]
})

-- AutoPairs for rust
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  command = [[ let b:AutoPairs = AutoPairsDefine({ 'r#"': '"#', "\w\zs<": ">", "|": "|"}) ]]
})

-- Make AutoPairs understand markup language angle brackets
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "xml" },
  command = [[  let b:AutoPairs = AutoPairsDefine({ '<': '>' }) ]]
})

-- Auto-complete HTML tags with omnicomplete
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  command = "inoremap </ </<C-x><C-o>"
})

-- Source relavent skeleton file
vim.cmd [[ autocmd BufNewFile *.py 0r ~/.local/share/nvim/templates/template.py ]]
vim.cmd [[ autocmd BufNewFile *.html 0r ~/.local/share/nvim/templates/template.html ]]
