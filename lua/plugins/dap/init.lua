local dap = require("dap")

require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

vim.fn.sign_define("DapBreakpoint", { icon = vim.g.breakpoint_symbol })

local opts = { remap = false }
vim.keymap.set("n", "<Leader>B", function()
    dap.toggle_breakpoint()
end, opts)
vim.keymap.set("n", "<C-c>", function()
    dap.continue()
end, opts)
