--========================================================================
-- Neovim Stable (version 0.8)
-- Toggleterm configuration
--========================================================================

-- Use vim movement keys to navigate within toggleterm
-- Escape (CapsLock) to enter NORMAL mode then use movement keys j, k,
-- <C-n>, <C-p>, <C-d>, <C-u> to move within the floating terminal
function _G.set_terminal_keymaps()
  local opts = { noremap = true, buffer = 0 }
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
end

vim.cmd [[ autocmd! TermOpen term://* lua set_terminal_keymaps() ]]

require("toggleterm").setup {

    size = 80,
    open_mapping = "<Leader><Space>",
    hide_numbers = true, -- hide the number column in toggleterm buffers

    -- Degree to darken terminal color (defaults: dark=1, light=3)
    shading_factor = 1,
    shade_terminals = true,
    shade_filetypes = {},

    direction = "float", -- options: vertical, horizontal, tab
    float_opts = {
        border = "curved", -- options: single, shadow, curved
        width = 120,
        height = 36,
        -- winblend = 0, -- ? transparency
    },
    winbar = {
        enabled = false,
        name_formatter = function(term)
            return term.name
        end
    },
}
