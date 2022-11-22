--=========================================================================
-- Neovim Stable (version 0.8)
-- nvim-dap: Debug Adaptor Protocol implementation for neovim
-- configurations
--=========================================================================

vim.fn.sign_define(
    'DapBreakpoint',
    { text = "■", texthl = "", linehl = "", numhl = "CursorLineNr" } -- ⚿ □
)

vim.fn.sign_define(
    'DapBreakpointRejected',
    { text = "□", texthl = "", linehl = "", numhl = "" }
)

vim.fn.sign_define(
    'DapStopped',
    { text = "➤", texthl = "", linehl = "Visual", numhl = "" } -- ▣
)

vim.fn.sign_define(
    'DapBreakpointCondition',
    { text = "Ⓒ", texthl = "", linehl = "", numhl = "" } -- ▣
)
