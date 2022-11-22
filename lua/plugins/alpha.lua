--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: plugins
--=========================================================================
local alpha = prequire("alpha")
local startify = prequire("alpha.themes.startify")

alpha.setup(startify.opts)
startify.section.bottom_buttons.val = {
    startify.button("v", "Neovim Config", "<cmd>e ~/.config/nvim/init.lua<cr>"),
    startify.button("q", "Quit Neovim", "<cmd>q<cr>")
}

vim.keymap.set("n", "<Leader>a", "<cmd>Alpha<cr>")
