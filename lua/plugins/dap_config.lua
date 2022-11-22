--========================================================================
-- Neovim Stable (version 0.8)
-- DAP Configuration
-- nvim-dap: Debug Adapter Protocol implementation for Neovim
--========================================================================

local dap = prequire "dap"
local dap_ui_widgets = prequire "dap.ui.widgets"

vim.fn.sign_define(
    'DapBreakpoint',
    { text = "⚿", texthl = "", linehl = "", numhl = "" }
)

vim.fn.sign_define(
    'DapBreakpointRejected',
    { text = "🟩", texthl = "", linehl = "", numhl = "" }
)

vim.fn.sign_define(
    'DapStopped',
    { text = "▣", texthl = "", linehl = "", numhl = "" }
)

vim.keymap.set('n', "<Leader>bb", function() dap.toggle_breakpoint() end)
vim.keymap.set('n', "<Leader>bc", function() dap.clear_breakpoints() end)
vim.keymap.set('n', "<Leader>cc", function() dap.continue() end)
vim.keymap.set('n', "<Leader>si", function() dap.step_into() end)
vim.keymap.set('n', "<Leader>so", function() dap.step_out() end)
vim.keymap.set('n', "<Leader>sO", function() dap.step_over() end)
vim.keymap.set('n', "<Leader>K", function() dap_ui_widgets.hover() end)

-- Setting up nvim-dap-python, with python installation with debugpy module
dap.adapters.python = {
    type = "executable",
    command = "~/.virtualenvs/debugpy/bin/python",
    args = { "-m", "debugpy.adapter" },
}
