--=========================================================================
-- Neovim Stable (version 0.8)
-- Plugin configuration: Telescope config
--=========================================================================
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  vim.notify_once("Need to install telescope.nvim", vim.log.levels.ERROR)
  return
end

require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

-- To get fzy loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzy_native")

local builtin = require("telescope.builtin")
Nnoremap("<Leader>ss", builtin.live_grep)
Nnoremap("<Leader>sf", builtin.find_files)
Nnoremap("<Leader>sb", builtin.buffers)
Nnoremap("<Leader>sh", builtin.help_tags)

-- Lazygit
local lazygit = require("plugins.lazygit")

if lazygit ~= nil then
  telescope.load_extension("lazygit")
  Nnoremap("<Leader>sr", telescope.extensions.lazygit.lazygit)
end
