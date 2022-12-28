function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<cmd>wincmd h<cr>]], opts)
  vim.keymap.set("t", "<C-j>", [[<cmd>wincmd j<cr>]], opts)
  vim.keymap.set("t", "<C-k>", [[<cmd>wincmd k<cr>]], opts)
  vim.keymap.set("t", "<C-l>", [[<cmd>wincmd l<cr>]], opts)
end

-- We only want these mapping for toggleterm
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

require("toggleterm").setup {
  direction = "float", -- orient terminal as a floating terminal
  open_mapping = [[<Leader><Space>]], -- keymapping to toggle/untoggle terminal
  hide_number = true, -- hide line numbers
  shade_filetypes = {},
  autochdir = false, -- change working directory along with neovim
  start_in_insert = true,
  insert_mappings = true, -- does open mapping apply in INSERT mode?
  terminal_mapping = true, -- does open mapping apply in opened terminals?
  shade_terminal = true,
  shading_factor = 1,
  persist_size = true,
  persist_mode = true,
  shell = vim.o.shell, -- default shell
  auto_scroll = true, -- scroll to bottom automatically on terminal output
  close_on_exit = true, -- close terminal process when parent nvim process exits
  float_opts = {
    width = 120,
    height = 38,
    winblend = 3,
    border = "double", -- single | double | shadow | curved (like nvim_open_win)
  },
  winbar = {
    enabled = false,
    name_formatter = function(term)
      return term.name -- term: Terminal
    end,
  },
}
