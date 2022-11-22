--=============================================================================
-- Neovim Nightly Edtion (version 0.8)
-- Show git diffs of current buffer in signcolumn, statusline & more
--=============================================================================
require('gitsigns').setup {
  -- New-style gitsigns symbols, from default configuration
  signs = {
    --  text = '∥│'
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    -- text = '_'
    delete       = {hl = 'GitSignsDelete', text = '━', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '✗', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    -- text = '~〜'
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  --> Toggle with `:Gitsigns toggle_signs`
  numhl      = false, --> Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, --> Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, --> Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, --> Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', --> 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, --> Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)

    local function set_keymap(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', {noremap=true, silent=true}, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Keymappings for navigation
    set_keymap('n', ']c', "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'", {expr=true})
    set_keymap('n', '[c', "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'", {expr=true})
    -- Keymappings for actions
    set_keymap('n', '<leader>hs', '<Cmd>Gitsigns stage_hunk<CR>')
    set_keymap('v', '<leader>hs', '<Cmd>Gitsigns stage_hunk<CR>')
    set_keymap('n', '<leader>hr', '<Cmd>Gitsigns reset_hunk<CR>')
    set_keymap('v', '<leader>hr', '<Cmd>Gitsigns reset_hunk<CR>')
    set_keymap('n', '<leader>hS', '<Cmd>Gitsigns stage_buffer<CR>')
    set_keymap('n', '<leader>hu', '<Cmd>Gitsigns undo_stage_hunk<CR>')
    set_keymap('n', '<leader>hR', '<Cmd>Gitsigns reset_buffer<CR>')
    set_keymap('n', '<leader>hp', '<Cmd>Gitsigns preview_hunk<CR>')
    set_keymap('n', '<leader>hb', '<Cmd>lua require("gitsigns").blame_line({full=true})<CR>')
    set_keymap('n', '<leader>tb', '<Cmd>Gitsigns toggle_current_line_blame<CR>')
    set_keymap('n', '<leader>hd', '<Cmd>Gitsigns diffthis<CR>')
    set_keymap('n', '<leader>hD', '<Cmd>lua require("gitsigns").diffthis("~")<CR>')
    set_keymap('n', '<leader>td', '<Cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    set_keymap('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    set_keymap('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
