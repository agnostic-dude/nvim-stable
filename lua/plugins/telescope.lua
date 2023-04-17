--=========================================================================
-- Neovim Stable (version 0.8)
-- Plugin configuration: Telescope config
--=========================================================================
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  vim.notify("Need to install telescope.nvim", vim.log.levels.ERROR)
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
telescope.load_extension("fzf")

local builtin = require("telescope.builtin")
Nnoremap("<Leader>fs", builtin.live_grep, { desc = "[f]ind [s]tring" })
Nnoremap("<Leader>ff", builtin.find_files, { desc = "[f]ind [f]ile" })
Nnoremap("<Leader>fb", builtin.buffers, { desc = "[f]ind [b]buffers" })
Nnoremap("<Leader>fh", builtin.help_tags, { desc = "[f]ind [h]elp tags" })
Nnoremap("<Leader>fd", builtin.diagnostics, { desc = "[f]ind [d]iagnostic msgs" })
Nnoremap("<Leader>fc", builtin.colorscheme, { desc = "[f]ind [c]olorscheme" })

-- Lazygit
local lazygit = require("plugins.lazygit")

if lazygit ~= nil then
  telescope.load_extension("lazygit")
  Nnoremap("<Leader>sr", telescope.extensions.lazygit.lazygit)
end
