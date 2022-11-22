--========================================================================
-- Neovim Stable (version 0.8)
-- nvim-dap: Debug Adapter Protocol implementation for Neovim
-- DAP configuration
--========================================================================

local dap = prequire "dap"
local dap_ui_widgets = prequire "dap.ui.widgets"

vim.keymap.set('n', "<Leader>x", function() dap.toggle_breakpoint() end)
vim.keymap.set('n', "<Leader>z", function() dap.continue() end)
vim.keymap.set('n', "<Leader>B", function() dap.clear_breakpoints() end)
vim.keymap.set('n', "<Leader>si", function() dap.step_into() end)
vim.keymap.set('n', "<Leader>so", function() dap.step_out() end)
vim.keymap.set('n', "<Leader>sO", function() dap.step_over() end)
vim.keymap.set('n', "<Leader>K", function() dap_ui_widgets.hover() end)
