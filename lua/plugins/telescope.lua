--=============================================================================
-- Neovim Stable (version 0.8)
-- Telescope configuration
--=============================================================================
local telescope = require "telescope"
telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker
        ["<C-h>"] = "which_key",

        -- <Esc> enters NORMAL mode by default, <Esc> twice to close window
        -- by default <C-c> closes floating window, following code make <Esc>
        -- close the floating window
        ["<Esc>"] = require("telescope.actions").close,
      }
    },
    -- Use terminal image viewer, like "catimg", to preview images in telescope
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(file_path)
          local image_extensions = { "png", "jpg" }
          local split_path = vim.split(file_path:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. '\r\n')
            end
          end

          vim.fn.jobstart(
            {
              "catimg", filepath -- terminal image viewer command
            },
            { on_stdout = send_output, stdout_buffered = true }
          )
        else
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
        end
      end
    }
  },

  pickers = {
    -- default config for builtin packers goes here
    -- picker_name = {
    --   picker_config_key = value,
    -- }
    -- now picker_config_key will be applied everytime you call this builtin
    -- picker
  },

  extensions = {
    --> native telescope sorter to improve sorting performance
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
}

-- Get fzf loaded and working with telescope
telescope.load_extension("fzy_native")

-- Get magic of telescope to DAP
telescope.load_extension("dap")
vim.keymap.set("n", "<Leader>df", "<cmd>Telescope dap frames<cr>")
vim.keymap.set("n", "<Leader>dc", "<cmd>Telescope dap commands<cr>")
vim.keymap.set("n", "<Leader>db", "<cmd>Telescope dap list_breakpoints<cr>")
